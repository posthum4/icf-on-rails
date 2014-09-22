module Service
  module Importer
    class OpportunityToCampaignOrder

      attr_accessor :sfdcid

      def initialize(opportunity,campaign_order)
        Rails.logger.info "Initializing Opportunity-to-CampaignOrder import..."
        @oppt = opportunity
        @co   = campaign_order
        import
        update_io_case
        Rails.logger.info "Imported Order #{@co.sfdcid} #{@co.name}"
      end

      def import
        @co.name                                    = @oppt['Name']
        @co.budget_currency                         = @oppt['CurrencyIsoCode']
        @co.amount                                  = @oppt['Amount'].to_f
        @co.budget_cents                            = @co.amount * Money::Currency.find(@co.budget_currency).subunit_to_unit
        @co.campaign_start_date                     = Chronic::parse(@oppt['Campaign_Start_Date__c'])
        @co.campaign_end_date                       = Chronic::parse(@oppt['Campaign_End_Date__c'])
        @co.opp_type_new                            = @oppt['Opp_Type_New__c']
        @co.original_opportunity                    = @oppt['Original_Opportunity__c']
        @co.stagename                               = @oppt['StageName']
        @co.closedate                               = Chronic::parse(@oppt['CloseDate'])
        @co.io_case                                 = @oppt['IO_Case__c']
        @co.lastmodifieddate                        = Chronic::parse(@oppt['LastModifiedDate'].to_s)
        @co.brand                                   = @oppt['Brand__c']
        @co.vertical                                = @oppt['Vertical__c']
        @co.advertiser                              = SalesForce::Account.find(@oppt.Advertiser__c).Name
        @co.account                                 = SalesForce::Account.find(@oppt.AccountId).Name
        @co.agency                                  = SalesForce::Account.find(@oppt.Agency__c).Name || SalesForce::Account.find(@oppt.AccountId).Name
        @co.sales_region                            = @oppt['Sales_Region__c']
        # Note that the salesforce username (part before @rocketfuel.com) is equal to the JIRA user name (part before @rocketfuelinc.com)
        # The only exception found so far is Edith Wu who is "ewu" in SalesForce and "edithwu" in JIRA. Need a manual correction for that... :(
        Rails.logger.info "Importing AE"
        @co.account_executive                       = ( SalesForce::User.find(@oppt.Opportunity_Owner_User__c).Email.split('@').first || 'robbie' ).sub('ewu','edithwu')
        Rails.logger.info "Importing split notes"
        @co.split_notes                             = Policy::SplitOwners.new(@co.sfdcid).splits.map{|k,v| "#{k}:#{v}"}.join(', ')
        Rails.logger.info "Importing AE2"
        @co.account_executive_2                     = Policy::SplitOwners.new(@co.sfdcid).splits.sort_by {|_key, value| value}.reverse![1][0] rescue nil
        Rails.logger.info "Importing AM"
        @co.account_manager                         = ( SalesForce::User.find(@oppt.Account_Manager__c).Email.split('@').first rescue 'aschneider' )
        @co.campaign_objectives                     = @oppt['Campaign_Objectives__c']
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
        @co.insights_package                        = @oppt['Insights_Package__c']
        @co.offline_sales_impact                    = @oppt['Offline_Sales_Impact__c']
        @co.viewability_vendor                      = @oppt['Who_is_Viewability_Vendor__c']
        @co.suppl_add_on_products                   = @oppt['Supplemental_Add_On_Products__c'].join("\n")
        @co.rm_ad_serving_fees                      = @oppt['RM_and_Serving_Fees__c']
        @co.who_is_paying_for_rm_ad_serving_fees    = @oppt['Who_is_Paying_for_RM_Serving_Fees__c']
        @co.who_is_rm_vendor                        = @oppt['Who_is_Rich_Media_Vendor__c']
        @co.viewability_metrics                     = @oppt['Viewability_Metrics__c']
        @co.who_is_paying_for_viewability           = @oppt['Who_is_Paying_for_Viewability__c']
        @co.customer_tier                           = SalesForce::Account.find(@oppt.Advertiser__c).Customer_Tier__c
        @co.save!
      end

      def update_io_case
        # also still present in campaign_order, may no
        # longer be necessary there
        if @co.io_case.nil?
          guesscase = SalesForce::Case.find_by_Opportunity__c(@co.sfdcid)
          unless guesscase.nil?
            @co.io_case = guesscase
          end
        end
        @co.io_case
      end


    end
  end
end
