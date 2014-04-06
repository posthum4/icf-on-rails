module Service
  class IssueCreator

    attr_accessor :sfdcid, :campaign_order, :jira, :fields, :description

    def initialize(campaign_order)
      @co     = campaign_order
      @sfdcid = @co.sfdcid
      @jira   = find_or_create_jira_by_campaign_order
      @fields = Value::Field.new
      import_from_sfdc
      @jira
    end

    # def find_or_create_jira_by_sfdcid
    #   return false unless @co
    #   return false unless @sfdcid
    #   binding.pry
    #   j = Jira::Issue.find_or_create_by_sfdcid(@sfdcid,self.subject)
    #   @co.jira_key = j.key
    #   @co.save
    #   j
    # end

    def find_or_create_jira_by_campaign_order
      return false unless @co
      j = Jira::Issue.find_or_create_by_campaign_order(@co,self.subject)
      @co.jira_key = j.key
      @co.save
      j
    end

    def jira_key
      @jira.key
    end

    def import_from_sfdc
      import_matched_fields
      import_tables
      import_attachments
    end

    def import_matched_fields
      @fields.jira_direct.each do |a|
        internal_field, jira_field = a
        @jira.set_field(jira_field, eval("@co.#{internal_field}"))
      end
      @jira.save
    end

    def import_tables
      @jira.set_field("description", ViewModel::Description.new(@sfdcid).to_s)
      @jira.set_field("customfield_12274", ViewModel::LineItemTable.new(@co).to_s)
      @jira.set_field("customfield_13360", ViewModel::TacticsTable.new(@co).to_s)
      @jira.save
    end

    def import_attachments
      amends = @co.attachments.select { |a| a.created_at > 7.days.ago }
      amends.each do |a|
        @jira.attach_file(a)
      end
    end

    def subject
      case @co.opp_type_new
      when 'Media: New Business', 'Enterprise: New Business'
        mymarker = 'Launch'
      else
        mymarker = 'Change'
      end
      "#{mymarker} #{@co.name} due #{@co.campaign_start_date}"
    end

  end
end
