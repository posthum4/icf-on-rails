module Service
  module Importer
    class OpportunityToCampaignOrder

      attr_accessor :sfdcid

      def initialize(opportunity,campaign_order)
        Rails.logger.info "Initializing Opportunity-to-CampaignOrder import..."
        @oppt = opportunity
        @co   = campaign_order
        @co.update_io_case
        import
        import_line_items(@co)
        Rails.logger.info "Imported Order #{@co.sfdcid} #{@co.name}"
      end

      def import
        @co.name                                    = @oppt['Name']
        @co.budget_currency                         = @oppt['CurrencyIsoCode']
        @co.amount                                  = @oppt['Amount'].to_f
        @co.budget_cents                            = @co.amount * Money::Currency.find(@co.budget_currency).subunit_to_unit
        @co.campaign_start_date                     = Chronic::parse(@oppt['Campaign_Start_Date__c'])
        @co.campaign_end_date                       = Chronic::parse(@oppt['Campaign_End_Date__c'])
        @co.scheduled_date                          = self.class.calculate_internal_due_date(Time.now, @co.campaign_start_date)
        @co.opp_type_new                            = @oppt['Opp_Type_New__c']
        @co.original_opportunity                    = @oppt['Original_Opportunity__c']
        @co.stagename                               = @oppt['StageName']
        @co.closedate                               = Chronic::parse(@oppt['CloseDate'])
        #@co.io_case                                = @oppt['IO_Case__c'] # Trying to put this back in again to solve a persistent bug
        @co.lastmodifieddate                        = Chronic::parse(@oppt['LastModifiedDate'].to_s)
        @co.brand                                   = @oppt['Brand__c']
        @co.vertical                                = @oppt['Vertical__c']
        @co.advertiser                              = SalesForce::Account.find(@oppt.Advertiser__c).Name
        @co.account                                 = SalesForce::Account.find(@oppt.AccountId).Name
        @co.sf_account_id                           = @oppt.AccountId
        @co.agency                                  = SalesForce::Account.find(@oppt.Agency__c).Name || SalesForce::Account.find(@oppt.AccountId).Name
        @co.sales_region                            = @oppt['Sales_Region__c']
        dplan                                       = SalesForce::DeliveryPlan.find(@oppt.Delivery_Plan__c)
        # Note that the salesforce username (part before @rocketfuel.com) is equal to the JIRA user name (part before @rocketfuelinc.com)
        # The only exception found so far is Edith Wu who is "ewu" in SalesForce and "edithwu" in JIRA. Need a manual correction for that... :(
        # found another one: jlilly in salesforce equals jguzman in JIRA. Mike launched QI-1203 for this change and a request with IT for a more fundamental process
        @co.split_notes                             = Policy::SplitOwners.new(@co.sfdcid).splits.map{|k,v| "#{k}:#{v}"}.join(', ')
        Rails.logger.info "SN = #{@co.split_notes}"
        #@co.account_executive                       = ( SalesForce::User.find(@oppt.OwnerId).Alias || 'robbie' ).sub('ewu','edithwu').sub('jlilly','jguzman')
        @co.account_executive                       = Policy::SplitOwners.new(@co.sfdcid).splits.sort_by {|_key, value| value}.reverse![0][0].sub('ewu','edithwu').sub('jlilly','jguzman') rescue 'robbie'
        Rails.logger.info "AE1 = #{@co.account_executive}"
        @co.account_executive_2                     = Policy::SplitOwners.new(@co.sfdcid).splits.sort_by {|_key, value| value}.reverse![1][0].sub('ewu','edithwu').sub('jlilly','jguzman') rescue nil
        Rails.logger.info "AE2 = #{@co.account_executive_2}"
        @co.account_manager                         = ( SalesForce::User.find(dplan.Account_Manager__c).Email.split('@').first rescue ENV['JIRA_DEFAULT_USER'] )
        Rails.logger.info "AM = #{@co.account_manager}"

        @co.campaign_objectives                     = dplan.Delivery_Objectives__c
        @co.insights_package                        = dplan.Insights_Package__c

        @co.primary_audience_am                     = @oppt['Primary_Audience_AM__c']
        @co.secondary_audience_am                   = @oppt['Secondary_Audience_AM__c']
        @co.hard_constraints_am                     = @oppt['Hard_Constraints_AM__c']
        @co.is_secondary_audience_a_hard_constraint = @oppt['Is_Secondary_Audience_a_Hard_Constraint__c']
        @co.rfp_special_client_requests             = @oppt['RFP_Special_Client_Requests__c'].join("\n")
        @co.special_client_requirements             = @oppt['Special_Client_Requirements__c'].join("\n")
        @co.special_notes                           = @oppt['Special_Notes__c']
        @co.brand_safety_vendor                     = @oppt['Brand_Safety_Vendor__c']
        @co.type_of_service                         = @oppt['Type_of_Service__c']
        @co.brand_safety_restrictions               = @oppt['Brand_Safety_Restrictions__c'].join("\n")
        @co.who_is_paying_for_brand_safety          = @oppt['Who_is_Paying_for_Brand_Safety__c']
        @co.client_vendor_pre_existing_relations    = @oppt['Client_Vendor_Pre_existing_relations__c']
        @co.who_will_implement_adchoices_icon       = @oppt['Who_will_Implement_AdChoices_Icon__c']
        @co.brand_safety_notes                      = @oppt['Brand_Safety_Notes__c']
        @co.who_will_wrap_the_tags                  = @oppt['Who_Will_Wrap_The_Tags__c']
        @co.viewability                             = @oppt['Viewability__c']
        @co.viewability_metrics                     = @oppt['Viewability_Metrics__c']
        @co.offline_sales_impact                    = @oppt['Offline_Sales_Impact__c']
        @co.viewability_vendor                      = @oppt['Who_is_Viewability_Vendor__c']
        @co.suppl_add_on_products                   = @oppt['Supplemental_Add_On_Products__c'].join("\n")
        @co.rm_ad_serving_fees                      = @oppt['RM_and_Serving_Fees__c']
        @co.who_is_paying_for_rm_ad_serving_fees    = @oppt['Who_is_Paying_for_RM_Serving_Fees__c']
        @co.who_is_rm_vendor                        = @oppt['Who_is_Rich_Media_Vendor__c']
        @co.viewability_metrics                     = @oppt['Viewability_Metrics__c']
        @co.who_is_paying_for_viewability           = @oppt['Who_is_Paying_for_Viewability__c']
        @co.customer_tier                           = SalesForce::Account.find(@oppt.Advertiser__c).Customer_Tier__c
        @co.opportunity_transcript                  = @oppt.attributes.compact.to_yaml
        @co.delivery_plan_transcript                = SalesForce::DeliveryPlan.find(@oppt.Delivery_Plan__c).attributes.compact.to_yaml
        @co.save!
      end

      def import_line_items(co)
        ## find all the line items attached to this opportunity
        opportunity_line_items=SalesForce::OpportunityLineItem.query("OpportunityId='#{co.sfdcid}'")
        oli_counter = 1
        ## loop through them with a count
        opportunity_line_items.each do |oli|
          ## and import each line item
          Service::Importer::OpportunityLineItemToLineItem.new(oli,co,oli_counter)
          ## and log back the count
          oli_counter += 1
        end
        Rails.logger.info "Imported #{@co.line_items.size} Line Items"
      end

      # Calculates the internal due date for a campaign launch
      #
      # If we have enough time (as measured by SLA) to launch a campaign by the requested start date (meaning the campaign
      # launch is completed BEFORE the start date), then the internal due date should be the business day before the requested
      # start date (i.e. internal_due_date = campaign_start_date - 1 business day)
      # If a launch comes in too late (i.e. we don't have SLA time to proccess it by the requested start date), then the
      # we will complete it according to our SLA (i.e. internal_due_date = SLA + received_date)
      #
      # Args:
      #     received_date (Time):
      #     campaign_start_date (Date):
      #
      # Returns:
      #     Time object
      #
      # Raises:
      #     CampaignStartDateUnexpectedValue
      #     ReceivedDateUnexpectedValue
      #
      def self.calculate_internal_due_date(received_date, campaign_start_date)
        
        #catch unepected inputs
        if campaign_start_date.nil?
          fail Exceptions::CampaignStartDateUnexpectedValue, campaign_start_date
        elsif !(campaign_start_date.class == Date)
          fail Exceptions::CampaignStartDateUnexpectedValue, campaign_start_date
        elsif received_date.nil?
          fail Exceptions::ReceivedDateUnexpectedValue, received_date
        elsif !received_date.is_a?(Time)
            fail Exceptions::ReceivedDateUnexpectedValue, received_date
        end

        puts "received date: #{received_date}"
        puts "campaign start date: #{campaign_start_date}"

        #save time zone offset
        utc_offset = received_date.utc_offset

        #convert inputs to Time objects in UTC standard time
        received_date = received_date.utc
        campaign_start_date = Time.new(campaign_start_date.year,campaign_start_date.month,campaign_start_date.day,0,0,0, "-00:00").utc

        #classify US holidays as non-business days
        #TODO this should be configured to Rocket Fuel holidays (https://docs.google.com/a/rocketfuelinc.com/file/d/0B-QY7UOcFIl3WWc2ZnMzZXlGLXM/edit)
        #     ---> see https://github.com/holidays/holidays#loading-custom-definitions-on-the-fly
        #     ---> requires making a .yml file like the ones found in: /Users/dan/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/holidays-2.2.0/data
        #TODO once configured to Rocket Fuel holidays, reconfigure 'holiday' tests in opportunity_to_campaign_order_spec.rb to appropriate values
        Holidays.between(Date.today, 2.years.from_now, :us, :observed).map{|holiday| BusinessTime::Config.holidays << holiday[:date]}

        # we'd like to complete the launch by 5pm the business day before the campaign starts. 
        requested_complete_by = custom_timezone(0.business_hour.before(campaign_start_date), "-00:00")

        business_hours_till_due = (received_date.business_time_until(requested_complete_by)) / Constants::SECONDS_IN_HOUR

        time_needed = Constants::SLA * Constants::BUSINESS_HOURS_IN_DAY

        if (business_hours_till_due >= time_needed)
            # we'll have enough time to launch as expected
            internal_due_date = requested_complete_by
        else
            # we don't have enough time... we'll launch according to SLA
            internal_due_date = custom_timezone(time_needed.business_hours.after(received_date), "-00:00")
        end

        internal_due_date = custom_timezone(internal_due_date, "%03d:00" % (utc_offset/Constants::SECONDS_IN_HOUR))
        puts "internal_due_date: #{internal_due_date}"

        return internal_due_date

      end


      # business_time gem has difficulty working w/ Rails configured timezones.
      # when using functions like '.business.hour.before()' or '.business_hours.after()' on DateTime objects, for example,
      # instead of returning a DateTime in the correct time zone, as expected, it returns an ActiveSupport::TimeWithZone
      # with unpredictable timezone behavior. however, everything aside from the timezone is accurate. for this reason,
      # this helper method deconstructs the ActiveSupport::TimeWithZone output, and reconstructs a DateTime object with
      # the correct Rails configured time zone.
      #
      # Args:
      #     active_support_object (type = ActiveSupport::TimeWithZone)
      #
      # Returns:
      #     DateTime object
      #
      def self.business_time_output_to_expected_datetime(aso)
        return DateTime.new(aso.year, aso.month, aso.day, aso.hour, aso.minute, aso.second, Time.now.strftime("%z"))
      end

      def self.business_to_utc_time(aso)
          return Time.new(aso.year, aso.month, aso.day, aso.hour, aso.min, aso.sec, "-00:00")
      end

      def self.custom_timezone(aso, zone)
          return Time.new(aso.year, aso.month, aso.day, aso.hour, aso.min, aso.sec, zone)
      end

    end
  end
end
