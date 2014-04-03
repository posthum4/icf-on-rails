class Importer

  attr_accessor :sfdcid, :campaign_order, :issue_importer

  def initialize(sfdcid)
    @sfdcid         = sfdcid
    @campaign_order = CampaignOrder.find_or_create_by(sfdcid: sfdcid)
    # @opportunity = SalesForce::Opportunity.find(@sfdcid)
    # @description = ViewModel::Description.new(@sfdcid).to_s
    # @fields = Value::Field.new
    # @jira = jira
    # self
  end

  # def import
  #   return false unless @opportunity
  #   return false unless @sfdcid
  #   # TODO: 2014-04-01 add full import flow here
  # end


end
