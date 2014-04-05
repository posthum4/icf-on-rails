module Service
  module Importer
    class OpportunityToLineItem

      def initialize(opportunity,campaign_order)
        Rails.logger.info "Initializing Opportunity-to-LineItemOrder import..."
        @oppt = opportunity
        @co   = campaign_order
        @curr = @co.budget_currency
        import
        Rails.logger.info "Imported #{@co.line_items.size} Line Items"
      end

      def import
        # DONE: 2014-04-05 refactor this into a specific line_item_importer
        # NOTE: this looks extremely hacky but it's because SalesForce is inconsistent with fields
        li = []
        (1..6).each do |l|
          li[l] = @co.line_items.find_or_create_by(ordinal: l)
        end
        li[1].add_on                      = @oppt['Line_Item_1_Add_on__c'].join("\n")
        li[1].amount                      = @oppt['LineItem1Amount__c']
        li[1].bonus_impressions           = @oppt['Bonus_Impressions_DR__c']
        li[1].cost                        = @oppt['Cost_DR__c']
        li[1].flight_instructions         = @oppt['Flight_Instructions_DR__c']
        li[1].goal                        = @oppt['Goal_DR__c']
        li[1].impressions                 = @oppt['Impressions_DR__c']
        li[1].io_line_item                = @oppt['IO_Line_Item_DR__c']
        li[1].media_channel               = @oppt['LineItem1MediaChannel__c']
        li[1].pricing_term                = @oppt['Line_Item_1_Pricing_Term__c']
        li[1].product                     = @oppt['Line_Item_1_Product__c']
        li[1].secondary_optimization_goal = @oppt['Line_Item_1_Secondary_Optimization_Goal__c']
        li[2].add_on                      = @oppt['Line_Item_2_Add_on__c'].join("\n")
        li[2].amount                      = @oppt['LineItem2Amount__c']
        li[2].bonus_impressions           = @oppt['Bonus_Impressions_Retargeting__c']
        li[2].cost                        = @oppt['Cost_Retargeting__c']
        li[2].flight_instructions         = @oppt['Flight_Instructions_Retargeting__c']
        li[2].goal                        = @oppt['Goal_Retargeting__c']
        li[2].impressions                 = @oppt['Impressions_Retargeting__c']
        li[2].io_line_item                = @oppt['IO_Line_Item_Retargeting__c']
        li[2].media_channel               = @oppt['LineItem2MediaChannel__c']
        li[2].pricing_term                = @oppt['Line_Item_2_Pricing_Term__c']
        li[2].product                     = @oppt['Line_Item_2_Product__c']
        li[2].secondary_optimization_goal = @oppt['Line_Item_2_Secondary_Optimization_Goal__c']
        li[3].add_on                      = @oppt['Line_Item_3_Add_on__c'].join("\n")
        li[3].amount                      = @oppt['LineItem3Amount__c']
        li[3].bonus_impressions           = @oppt['Bonus_Impressions_Brand__c']
        li[3].cost                        = @oppt['Cost_Brand__c']
        li[3].flight_instructions         = @oppt['Flight_Instructions_Brand__c']
        li[3].goal                        = @oppt['Goal_Brand__c']
        li[3].impressions                 = @oppt['Impressions_Brand__c']
        li[3].io_line_item                = @oppt['IO_Line_Item_Brand__c']
        li[3].media_channel               = @oppt['LineItem3MediaChannel__c']
        li[3].pricing_term                = @oppt['Line_Item_3_Pricing_Term__c']
        li[3].product                     = @oppt['Line_Item_3_Product__c']
        li[3].secondary_optimization_goal = @oppt['Line_Item_3_Secondary_Optimization_Goal__c']
        li[4].add_on                      = @oppt['Line_Item_4_Add_on__c'].join("\n")
        li[4].amount                      = @oppt['LineItem4Amount__c']
        li[4].bonus_impressions           = @oppt['Bonus_Impressions_Video__c']
        li[4].cost                        = @oppt['Cost_Video__c']
        li[4].flight_instructions         = @oppt['Flight_Instructions_Video__c']
        li[4].goal                        = @oppt['Goal_Video__c']
        li[4].impressions                 = @oppt['Impressions_Video__c']
        li[4].io_line_item                = @oppt['IO_Line_Item_Video__c']
        li[4].media_channel               = @oppt['LineItem4MediaChannel__c']
        li[4].pricing_term                = @oppt['Line_Item_4_Pricing_Term__c']
        li[4].product                     = @oppt['Line_Item_4_Product__c']
        li[4].secondary_optimization_goal = @oppt['Line_Item_4_Secondary_Optimization_Goal__c']
        li[5].amount                      = @oppt['LineItem5Amount__c']
        li[5].bonus_impressions           = @oppt['Bonus_Impressions_Social__c']
        li[5].cost                        = @oppt['Cost_Social__c']
        li[5].flight_instructions         = @oppt['Flight_Instructions_Social__c']
        li[5].goal                        = @oppt['Goal_Social__c']
        li[5].impressions                 = @oppt['Impressions_Social__c']
        li[5].io_line_item                = @oppt['IO_Line_Item_Social__c']
        li[5].media_channel               = @oppt['LineItem5MediaChannel__c']
        li[5].pricing_term                = @oppt['Line_Item_5_Pricing_Term__c']
        li[5].product                     = @oppt['Line_Item_5_Product__c']
        li[5].secondary_optimization_goal = @oppt['Line_Item_5_Secondary_Optimization_Goal__c']
        li[6].add_on                      = @oppt['Line_Item_6_Add_on__c'].join("\n")
        li[6].amount                      = @oppt['LineItem6Amount__c']
        li[6].bonus_impressions           = @oppt['Bonus_Impressions_RTBO__c']
        li[6].cost                        = @oppt['Cost_RTBO__c']
        li[6].flight_instructions         = @oppt['Flight_Instructions_RTBO__c']
        li[6].goal                        = @oppt['Goal_RTBO__c']
        li[6].impressions                 = @oppt['Impressions_RTBO__c']
        li[6].io_line_item                = @oppt['IO_Line_Item_RTBO__c']
        li[6].media_channel               = @oppt['LineItem6MediaChannel__c']
        li[6].pricing_term                = @oppt['Line_Item_6_Pricing_Term__c']
        li[6].product                     = @oppt['Line_Item_6_Product__c']
        (1..6).each do |l|
          li[l].budget_currency           = @co.budget_currency
          factor = Money::Currency.find(@co.budget_currency).subunit_to_unit
          li[l].budget_cents                = li[l].amount.to_f * factor
          li[l].price_cents                = li[l].cost.to_f * factor
          Rails.logger.level = Logger::DEBUG
          Rails.logger.debug "#{li[l].impressions} #{li[l].bonus_impressions}"
          if (
              ( li[l].impressions.nil? || li[l].impressions == 0 ) &&
              ( li[l].bonus_impressions.nil? || li[l].bonus_impressions == 0 )
            )
            Rails.logger.debug "Destroying Line Item #{l}"
            li[l].destroy
          else
            li[l].save!
          end
        end
      end
    end

  end
end
