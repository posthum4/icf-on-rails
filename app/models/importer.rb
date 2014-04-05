class Importer

  attr_accessor :sfdcid, :campaign_order, :issue_importer

  def initialize(sfdcid)
    Rails.logger.level = Logger::DEBUG
    @sfdcid         = sfdcid
    @campaign_order = CampaignOrder.find_or_create_by(sfdcid: sfdcid)
    import
    # @opportunity = SalesForce::Opportunity.find(@sfdcid)
    # @description = ViewModel::Description.new(@sfdcid).to_s
    # @fields = Value::Field.new
    # @jira = jira
    # self
  end

  def import
    Rails.logger.info "Starting on General Import Script"
    #return false unless @campaign_order
    #return false unless @sfdcid
    oppt = SalesForce::Opportunity.find(@sfdcid)
    # TODO: 2014-04-01 add full import flow here
    #@campaign_order.import_from_salesforce
    i1 = Service::Importer::OpportunityToCampaignOrder.new(oppt, @campaign_order)
    @campaign_order.import_line_items
    @campaign_order.reference_attachments
  end

end
