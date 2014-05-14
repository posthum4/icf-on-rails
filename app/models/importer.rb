class Importer
  attr_accessor :sfdcid, :campaign_order, :issue_importer

  def initialize(sfdcid,msgid=nil)
    @sfdcid_orig    = sfdcid
    @sfdcid         = ''
    @msg_id         = msgid
    check_sfdcid
    @campaign_order = CampaignOrder.find_or_create_by(sfdcid: @sfdcid)
    self
  end

  def import_and_export
    import and export
  end

  def import(force=false)
    fail Exceptions::JiraAlreadyExistsError, @campaign_order.jira_key if (force && !@campaign_order.jira_key.nil?)
    # check if imported already
    skipimport = true  if !force &&  !( @campaign_order.name.nil? || @campaign_order.line_items.nil? )
    Rails.logger.info "skipimport = #{skipimport} for #{@sfdcid}"
    Rails.logger.info "Starting on General Import Script for #{@sfdcid}"
    #return false unless @campaign_order
    #return false unless @sfdcid
    oppt = SalesForce::Opportunity.find(@sfdcid)
    # TODO: 2014-04-01 add full import flow here
    #@campaign_order.import_from_salesforce
    unless skipimport
      Service::Importer::OpportunityToCampaignOrder.new(oppt, @campaign_order)
      Service::Importer::OpportunityToLineItem.new(oppt, @campaign_order)
      Service::Importer::Attachments.new(oppt, @campaign_order)
    end
    self
  end

  def export
    jex = Service::IssueCreator.new(@campaign_order)
    jex.import_from_campaign_order
  end

  def check_sfdcid
    Rails.logger.info "Checking sfdcid for #{@sfdcid_orig}"
    fail Exceptions::MissingSalesForceOpportunityID, @sfdcid_orig, @sfdcid if ( @sfdcid_orig.nil? or !@sfdcid_orig )
    fail Exceptions::ReceivedCaseIDbutNeedOpportunityID, @sfdcid_orig if @sfdcid_orig =~ (/5008000000\w{5}/)
    # TODO: 2014-04-06 this may have to be a policy object
    matcher = @sfdcid_orig.match(/0068000000\w{5}/)
    if matcher.nil?
      fail Exceptions::InvalidSalesForceOpportunityID, @sfdcid_orig.to_s
    else
      @sfdcid = matcher[0]
    end
  end

end
