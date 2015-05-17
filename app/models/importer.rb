class Importer
  attr_accessor :sfdcid_orig, :sfdcid, :campaign_order, :parent_sfdcid, :jira, :parent_co, :parent_jira

  def initialize(sfdcid,msgid=nil)
    @sfdcid_orig    = sfdcid
    @sfdcid         = Policy::OpportunityID.validate(@sfdcid_orig)
    @msg_id         = msgid
    @campaign_order = CampaignOrder.find_or_create_by(sfdcid: @sfdcid)
    @parent_sfdcid  = @campaign_order.original_opportunity[0..14] rescue nil
    @parent_co      = CampaignOrder.find_or_create_by(sfdcid: @parent_sfdcid) rescue nil
    @parent_jira    = nil
    @jira           = nil
    self
  end

  def importexport
    import_child
    unless @campaign_order.original_opportunity.nil?
      @parent_sfdcid  = @campaign_order.original_opportunity[0..14] || ''
      @parent_co      = CampaignOrder.find_or_create_by(sfdcid: @parent_sfdcid) || ''
      import_parent
      export_parent
    end
    export_child
    Rails.logger.info "https://na6.salesforce.com/#{self.sfdcid} >> #{ENV['JIRA_API']}/browse/#{self.jira}"
    self
  rescue Exceptions::DealDeskCaseMissing_NeedToSubmitForApprovalBeforeICFCanImport => e
    errstring = "ERROR:"
    errstring << "\n"
    errstring <<  "Missing deal desk case. Opportunity #{sfdcid} needs to be"
    errstring << "\n"
    errstring << "submitted to deal desk before ICF can import it."
    errstring << "\n"
    errstring << e.message
    puts errstring
  rescue StandardError => e
    # errstring = "ERROR:"
    # errstring << "\n"
    # errstring  = "Other error occurred with opportunity #{sfdcid}."
    # errstring << "\n"
    # errstring << e.message
    #puts errstring
    puts "Error during processing: #{$!}"
    puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
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
      #TOBEADDEDLATER Service::Importer::DeliveryPlanToCampaignOrder.new(delplan, @campaign_order)
      Service::Importer::OpportunityToCampaignOrder.new(oppt, @campaign_order)
      Service::Importer::OpportunityToLineItem.new(oppt, @campaign_order)
      Service::Importer::Attachments.new(oppt, @campaign_order)
    end
    self
  end

  def export_child
    jex = Service::IssueCreator.new(@campaign_order,false)
    @jira = jex.import_from_campaign_order.key
  end

  def export_parent
    jex = Service::IssueCreator.new(@parent_co,true)
    @parent_jira = jex.import_from_campaign_order.key
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
