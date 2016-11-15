module Service
  module Importer
    class OpportunityLineItemToLineItem

      def initialize(opportunity_line_item,campaign_order,line_item_number)
        Rails.logger.info "Initializing OpportunityLineItem-to-LineItem import... #{line_item_number} #{opportunity_line_item.Id}"
        @oli            = opportunity_line_item
        @co             = campaign_order
        @lino           = line_item_number
        @curr           = @co.budget_currency
        import
        Rails.logger.info "Imported opportunity line item #{@oli.Id}"
      end

      def import
        li = @co.line_items.find_or_create_by(ordinal: @lino)
        # amounts
        li.impressions                 = ( @oli['Quantity'].to_i || 0 )
        li.bonus_impressions           = ( @oli['Bonus_Impressions__c'].to_i || 0 )
        li.cost                        = @oli['Price__c'].to_f
        li.budget_currency             = @oli['CurrencyIsoCode']
        li.pricing_term                = @oli['Rate_Type__c']
        li.amount                      = @oli['Gross_Total_Price__c'].to_f
        factor                         = Money::Currency.find(@co.budget_currency).subunit_to_unit.to_f
        li.budget_cents                = li.amount * factor
        li.price_cents                 = li.cost * factor

        # product
        li.io_line_item                = @oli['Opp_Product_Name__c']
        li.shortname                   = li.io_line_item
        li.product                     = @oli['Product_Name__c']
        li.media_channel               = @oli['Media_Channel__c']
        li.ad_format                   = @oli['Ad_Format__c']
        li.add_on                      = @oli['Add_On_Product_Detail__c'].to_s
        li.inventory_type              = @oli['Inventory_Type__c']

        # instructions
        li.flight_instructions         = @oli['Flight_Instructions__c']
        li.goal                        = @oli['Optimization_Goal__c']
        li.secondary_optimization_goal = @oli['Optimization_Details__c']
        li.save!
      end

      def old_import
        any_non_zero = false
        # DONE: 2014-04-05 refactor this into a specific line_item_importer
        # NOTE: this looks extremely hacky but it's because SalesForce is inconsistent with fields
        (1..6).each do |n|
          nn = MAP[n]
          if nonzero?(@oppt,nn)
            Rails.logger.info "Line item #{n} (ex-#{nn}) is non zero."

            import_individual_fields(_line_item, n.to_s, nn)
            _line_item.save!
            any_non_zero = true
          else
            Rails.logger.info "Line item #{n} (ex-#{nn}) is nil."
          end
        end
        generate_shortnames if any_non_zero
      end

      def import_individual_fields(li, n, nn)
        li.add_on                      = @oppt["Line_Item_#{n}_Add_on__c"].join("\n") unless n == '5' # missing from SFDC for li[5]
        li.amount                      = @oppt["LineItem#{n}Amount__c"].to_f
        li.pricing_term                = @oppt["Line_Item_#{n}_Pricing_Term__c"]
        li.product                     = @oppt["Line_Item_#{n}_Product__c"]
        li.secondary_optimization_goal = @oppt["Line_Item_#{n}_Secondary_Optimization_Goal__c"] unless n == '6' # missing from SFDC for li[6]
        li.media_channel               = @oppt["LineItem#{n}MediaChannel__c"]
        li.bonus_impressions           = ( @oppt["Bonus_Impressions_#{nn}__c"].to_i || 0 )
        li.cost                        = @oppt["Cost_#{nn}__c"].to_f
        li.flight_instructions         = @oppt["Flight_Instructions_#{nn}__c"]
        li.goal                        = @oppt["Goal_#{nn}__c"]
        li.impressions                 = ( @oppt["Impressions_#{nn}__c"].to_i || 0 )
        li.io_line_item                = @oppt["IO_Line_Item_#{nn}__c"]

        li.budget_currency             = @co.budget_currency
        factor                         = Money::Currency.find(@co.budget_currency).subunit_to_unit.to_f
        li.budget_cents                = li.amount * factor
        li.price_cents                 = li.cost * factor
      end

      def generate_shortnames
        substring = Value::CommonLineItemSubstring.new(@co).to_s
        @co.line_items.each do |li|
          li.shortname = li.io_line_item
          li.shortname.sub!(substring,'..') if substring.size > 3
          li.save!
        end
      end

      def nonzero?(oppt,nn)
        begin
          paid = oppt["Impressions_#{nn}__c"].to_i
        rescue
          paid = 0
        end
        begin
          bonus = oppt["Bonus_Impressions_#{nn}__c"].to_i
        rescue
          bonus = 0
        end
        active = paid + bonus
        Rails.logger.debug "Line Item #{nn}: paid = #{paid}, bonus = #{bonus} active #{active}"
        active != 0 ? true : false
      end

    end
  end
end
