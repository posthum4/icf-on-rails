class Importer
  attr_accessor :sfdcid, :campaign_order, :issue_importer

  def initialize(sfdcid,msgid=nil)
    @sfdcid_orig    = sfdcid
    @sfdcid         = ''
    @msg_id         = msgid
    check_sfdcid
    @campaign_order = CampaignOrder.find_or_create_by(sfdcid: @sfdcid)
    @parent_sfdcid  = @campaign_order.original_opportunity[0..14] rescue nil
    @parent_co      = CampaignOrder.find_or_create_by(sfdcid: @parent_sfdcid) rescue nil
    self
  end

  def importexport
    import_child
    @parent_sfdcid  = @campaign_order.original_opportunity[0..14] rescue nil
    @parent_co      = CampaignOrder.find_or_create_by(sfdcid: @parent_sfdcid) rescue nil
    unless @parent_co.nil?
      import_parent
      export_parent
    end
    export_child
  end

  def import_child(force=false)
    # check if imported already
    skipimport = true  if !force &&  !( @campaign_order.name.nil? || @campaign_order.line_items.nil? )
    Rails.logger.info "skipimport = #{skipimport} for (child) #{@sfdcid}"
    Rails.logger.info "Starting on General Import Script for (child) #{@sfdcid}"
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

  def export_child
    jex = Service::IssueCreator.new(@campaign_order,false)
    jex.import_from_campaign_order.key
  end

  def export_parent
    jex = Service::IssueCreator.new(@parent_co,true)
    jex.import_from_campaign_order.key
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

  def import_parent(force=false)
    # check if imported already
    skipimport = true  if !force &&  !( @parent_co.name.nil? || @parent_co.line_items.nil? )
    Rails.logger.info "Starting on General Import Script for parent #{@parent_sfdcid}"
    #return false unless @campaign_order
    #return false unless @sfdcid
    oppt = SalesForce::Opportunity.find(@parent_sfdcid)
    # TODO: 2014-04-01 add full import flow here
    #@campaign_order.import_from_salesforce
    unless skipimport
      Service::Importer::OpportunityToCampaignOrder.new(oppt, @parent_co)
      Service::Importer::OpportunityToLineItem.new(oppt, @parent_co)
    end
    self
  end

end
