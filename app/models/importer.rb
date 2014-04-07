class Importer
  attr_accessor :sfdcid, :campaign_order, :issue_importer

  class InvalidSalesForceOpportunityError < StandardError ; end

  def initialize(sfdcid)
    @sfdcid         = sfdcid
    check_sfdcid
    @campaign_order = CampaignOrder.find_or_create_by(sfdcid: @sfdcid)
  end

  def import_and_export
    import and export
  end

  def import
    fail Exceptions::InvalidSalesForceOpportunityError if @sfdcid.nil?
    Rails.logger.info "Starting on General Import Script for #{@sfdcid}"
    #return false unless @campaign_order
    #return false unless @sfdcid
    oppt = SalesForce::Opportunity.find(@sfdcid)
    # TODO: 2014-04-01 add full import flow here
    #@campaign_order.import_from_salesforce
    Service::Importer::OpportunityToCampaignOrder.new(oppt, @campaign_order)
    Service::Importer::OpportunityToLineItem.new(oppt, @campaign_order)
    Service::Importer::Attachments.new(oppt, @campaign_order)
  end

  def export
    jex = Service::IssueCreator.new(@campaign_order)
    jex.import_from_campaign_order
  end

  def check_sfdcid
    # TODO: 2014-04-06 this may have to be a policy object
    matcher = @sfdcid.match(/0068000000\w{5}/)
    if matcher.nil?
      fail InvalidSalesForceOpportunityError, @sfdcid.to_s
    else
      @sfdcid = matcher[0]
    end
  end

end
