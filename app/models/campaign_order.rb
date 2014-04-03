class CampaignOrder < ActiveRecord::Base

  validates_presence_of :sfdcid
  validates_uniqueness_of :sfdcid

  # #has_many :line_items
  # #references :opportunities

  #before_save :import_from_salesforce
  # #before_save :find_or_create_linked_issue

  def import_from_salesforce
    oppt = SalesForce::Opportunity.find(self.sfdcid)
    self.name = oppt['Name']
    self.amount = oppt['Amount'].to_f
    self.currencyisocode = oppt['CurrencyIsoCode']
    self.campaign_start_date = Chronic::parse(oppt['Campaign_Start_Date__c'])
    self.campaign_end_date = Chronic::parse(oppt['Campaign_End_Date__c'])
    self.opp_type_new = oppt['Opp_Type_New__c']
    self.original_opportunity = oppt['Original_Opportunity__c']
    self.stagename = oppt['StageName']
    self.closedate = Chronic::parse(oppt['CloseDate'])
    self.io_case = oppt['IO_Case__c']
    self.lastmodifieddate = Chronic::parse(oppt['LastModifiedDate'].to_s)
    self.brand = oppt['Brand__c']
    self.vertical = oppt['Vertical__c']
    self.advertiser = SalesForce::Account.find(oppt.Advertiser__c).Name
    self.account = SalesForce::Account.find(oppt.AccountId).Name
    self.agency = SalesForce::Account.find(oppt.Agency__c).Name
    self.sales_region = oppt['Sales_Region__c']
    self.account_executive = SalesForce::User.find(oppt.Opportunity_Owner_User__c).Email.split('@').first
    self.account_manager = SalesForce::User.find(oppt.Account_Manager__c).Email.split('@').first
    self.campaign_objectives = oppt['Campaign_Objectives__c']
    self.primary_audience_am = oppt['Primary_Audience_AM__c']
    self.secondary_audience_am = oppt['Secondary_Audience_AM__c']
    self.hard_constraints_am = oppt['Hard_Constraints_AM__c']
    self.is_secondary_audience_a_hard_constraint = oppt['Is_Secondary_Audience_a_Hard_Constraint__c']
    self.rfp_special_client_requests = oppt['RFP_Special_Client_Requests__c'].join("\n")
    self.special_client_requirements = oppt['Special_Client_Requirements__c'].join("\n")
    self.special_notes = oppt['Special_Notes__c']
    self.brand_safety_vendor = oppt['Brand_Safety_Vendor__c']
    self.type_of_service = oppt['Type_of_Service__c']
    self.brand_safety_restrictions = oppt['Brand_Safety_Restrictions__c'].join("\n")
    self.who_is_paying_for_brand_safety = oppt['Who_is_Paying_for_Brand_Safety__c']
    self.client_vendor_pre_existing_relations = oppt['Client_Vendor_Pre_existing_relations__c']
    self.who_will_implement_adchoices_icon = oppt['Who_will_Implement_AdChoices_Icon__c']
    self.brand_safety_notes = oppt['Brand_Safety_Notes__c']
    self.who_will_wrap_the_tags = oppt['Who_Will_Wrap_The_Tags__c']
    self.viewability = oppt['Viewability__c']
    self.viewability_metrics = oppt['Viewability_Metrics__c']
    self.who_is_paying_for_viewability = oppt['Who_is_Paying_for_Viewability__c']
    self.save!
  end

  def self.import_hardcode
    fields         = Value::Field.new.from_oppt_to_co
    hardcode       = ''
    fields.each do |a|
      oppt_field, co_field = a
      hardcode << "self.#{co_field} = oppt['#{oppt_field}']\n"
    end
    hardcode
  end

end

# def oppt_name
#   SalesForce::Opportunity.find(sfdcid).Name
# end

# def oppt
#   SalesForce::Opportunity.find(sfdcid)
# end

# def oppt_type
#   SalesForce::Opportunity.find(sfdcid).Opp_Type_New__c
# end

# # def overview
# #   result = []
# #   Field.initialize
# #   Value::Field.for_campaign_order.each do |f|
# #     result << { f: oppt[f] }
# #   end
# #   result
# # end

# private

# def exists_in_salesforce?
#   logger.debug "\n\n #{self.to_yaml}\n self = #{self.class}\n#{__FILE__}:#{__LINE__}"
#   logger.debug "\n\n #{self.sfdcid.to_yaml}\n self.sfdcid = #{self.sfdcid.class}\n#{__FILE__}:#{__LINE__}"
#   SalesForce::Opportunity.find(self.sfdcid)
# end

# def find_or_create_linked_issue
#   logger.level = Logger::DEBUG
#   logger.debug "We're in Order.after_save now {__FILE__}:#{__LINE__}"
#   @jira_key = Service::IssueCreator.new(self.sfdcid).jira_key
#   self.save
# end

# # def self.find_by(*args)
# #   records = super
# #   if records.nil? && args[0].keys.include?(:jira_key)
# #     # TODO: 2014-03-29 make values[0] more robust in case of 2+ argument queries
# #     jira_key = args[0].values[0]
# #     k = Jira::Issue.find_by_key(jira_key).first.sfdcid
# #     o = Service::IssueCreator.new(k).campaign_order
# #     records = super
# #   end
# #   records
# # end

# # def self.find_or_create_by(*args)
# #   # copied from self.find_by
# #   records = super
# #   if records.nil? && args[0].keys.include?(:jira_key)
# #     # TODO: 2014-03-29 make values[0] more robust in case of 2+ argument queries
# #     jira_key = args[0].values[0]
# #     k = Jira::Issue.find_by_key(jira_key).first.sfdcid
# #     o = Service::IssueCreator.new(k).campaign_order
# #     records = super
# #   end
# #   records
# # end
