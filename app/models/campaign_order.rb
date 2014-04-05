class CampaignOrder < ActiveRecord::Base

  validates_presence_of :sfdcid
  validates_uniqueness_of :sfdcid

  has_many :line_items
  has_many :attachments
  # #references :opportunities

  #before_save :import_from_salesforce
  # #before_save :find_or_create_linked_issue


  def reference_attachments
    Rails.logger.info "Importing Attachments..."
    unless self.io_case.nil?
      SalesForce::Attachment.find_all_by_ParentId(self.io_case).each do |f|
        logger.debug "\n\n #{f.to_yaml}\n f = #{f.class}\n#{__FILE__}:#{__LINE__}"
        a = self.attachments.find_or_create_by(sfdcid: f.Id)
        a.name           = f.Name
        a.content_type   = f.ContentType
        a.body           = f.Body
        a.created_at     = f.CreatedDate
        a.save!
      end
    end
  end

  def update_io_case
    # also moved this to to opportynity_to_campaign_order importer, may no
    # longer be necessary here
    if self.io_case.nil?
      guesscase = SalesForce::Case.find_by_Opportunity__c(sfdcid)
      unless guesscase.nil?
        self.io_case = guesscase
        self.save!
      end
    end
    self.io_case
  end

  def parent_id
  end



  def import_line_items
    # TODO: 2014-04-05 refactor this into a specific line_item_importer
    # that is called from an overall importer object, not from within
    # the campaign order
    Rails.logger.info "Importing LineItems..."
    oppt = SalesForce::Opportunity.find(self.sfdcid)
    # this looks extremely hacky but it's because SalesForce is inconsistent with fields
    li = []
    (1..6).each do |l|
      li[l] = self.line_items.find_or_create_by(ordinal: l)
    end
    li[1].add_on = oppt['Line_Item_1_Add_on__c'].join("\n")
    li[1].amount = oppt['LineItem1Amount__c']
    li[1].bonus_impressions = oppt['Bonus_Impressions_DR__c']
    li[1].cost = oppt['Cost_DR__c']
    li[1].flight_instructions = oppt['Flight_Instructions_DR__c']
    li[1].goal = oppt['Goal_DR__c']
    li[1].impressions = oppt['Impressions_DR__c']
    li[1].io_line_item = oppt['IO_Line_Item_DR__c']
    li[1].media_channel = oppt['LineItem1MediaChannel__c']
    li[1].pricing_term = oppt['Line_Item_1_Pricing_Term__c']
    li[1].product = oppt['Line_Item_1_Product__c']
    li[1].secondary_optimization_goal = oppt['Line_Item_1_Secondary_Optimization_Goal__c']
    li[2].add_on = oppt['Line_Item_2_Add_on__c'].join("\n")
    li[2].amount = oppt['LineItem2Amount__c']
    li[2].bonus_impressions = oppt['Bonus_Impressions_Retargeting__c']
    li[2].cost = oppt['Cost_Retargeting__c']
    li[2].flight_instructions = oppt['Flight_Instructions_Retargeting__c']
    li[2].goal = oppt['Goal_Retargeting__c']
    li[2].impressions = oppt['Impressions_Retargeting__c']
    li[2].io_line_item = oppt['IO_Line_Item_Retargeting__c']
    li[2].media_channel = oppt['LineItem2MediaChannel__c']
    li[2].pricing_term = oppt['Line_Item_2_Pricing_Term__c']
    li[2].product = oppt['Line_Item_2_Product__c']
    li[2].secondary_optimization_goal = oppt['Line_Item_2_Secondary_Optimization_Goal__c']
    li[3].add_on = oppt['Line_Item_3_Add_on__c'].join("\n")
    li[3].amount = oppt['LineItem3Amount__c']
    li[3].bonus_impressions = oppt['Bonus_Impressions_Brand__c']
    li[3].cost = oppt['Cost_Brand__c']
    li[3].flight_instructions = oppt['Flight_Instructions_Brand__c']
    li[3].goal = oppt['Goal_Brand__c']
    li[3].impressions = oppt['Impressions_Brand__c']
    li[3].io_line_item = oppt['IO_Line_Item_Brand__c']
    li[3].media_channel = oppt['LineItem3MediaChannel__c']
    li[3].pricing_term = oppt['Line_Item_3_Pricing_Term__c']
    li[3].product = oppt['Line_Item_3_Product__c']
    li[3].secondary_optimization_goal = oppt['Line_Item_3_Secondary_Optimization_Goal__c']
    li[4].add_on = oppt['Line_Item_4_Add_on__c'].join("\n")
    li[4].amount = oppt['LineItem4Amount__c']
    li[4].bonus_impressions = oppt['Bonus_Impressions_Video__c']
    li[4].cost = oppt['Cost_Video__c']
    li[4].flight_instructions = oppt['Flight_Instructions_Video__c']
    li[4].goal = oppt['Goal_Video__c']
    li[4].impressions = oppt['Impressions_Video__c']
    li[4].io_line_item = oppt['IO_Line_Item_Video__c']
    li[4].media_channel = oppt['LineItem4MediaChannel__c']
    li[4].pricing_term = oppt['Line_Item_4_Pricing_Term__c']
    li[4].product = oppt['Line_Item_4_Product__c']
    li[4].secondary_optimization_goal = oppt['Line_Item_4_Secondary_Optimization_Goal__c']
    li[5].amount = oppt['LineItem5Amount__c']
    li[5].bonus_impressions = oppt['Bonus_Impressions_Social__c']
    li[5].cost = oppt['Cost_Social__c']
    li[5].flight_instructions = oppt['Flight_Instructions_Social__c']
    li[5].goal = oppt['Goal_Social__c']
    li[5].impressions = oppt['Impressions_Social__c']
    li[5].io_line_item = oppt['IO_Line_Item_Social__c']
    li[5].media_channel = oppt['LineItem5MediaChannel__c']
    li[5].pricing_term = oppt['Line_Item_5_Pricing_Term__c']
    li[5].product = oppt['Line_Item_5_Product__c']
    li[5].secondary_optimization_goal = oppt['Line_Item_5_Secondary_Optimization_Goal__c']
    li[6].add_on = oppt['Line_Item_6_Add_on__c'].join("\n")
    li[6].amount = oppt['LineItem6Amount__c']
    li[6].bonus_impressions = oppt['Bonus_Impressions_RTBO__c']
    li[6].cost = oppt['Cost_RTBO__c']
    li[6].flight_instructions = oppt['Flight_Instructions_RTBO__c']
    li[6].goal = oppt['Goal_RTBO__c']
    li[6].impressions = oppt['Impressions_RTBO__c']
    li[6].io_line_item = oppt['IO_Line_Item_RTBO__c']
    li[6].media_channel = oppt['LineItem6MediaChannel__c']
    li[6].pricing_term = oppt['Line_Item_6_Pricing_Term__c']
    li[6].product = oppt['Line_Item_6_Product__c']
    (1..6).each do |l|
      li[l].save!
      logger.debug "#{li[l].impressions} #{li[l].bonus_impressions}"
      if (
          ( li[l].impressions.nil? || li[l].impressions == 0 ) &&
          ( li[l].bonus_impressions.nil? || li[l].bonus_impressions == 0 )
        )
        logger.warn "Destroying Line Item #{l}"
        li[l].destroy
      end
    end
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
