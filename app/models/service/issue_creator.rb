module Service
  class IssueCreator

    class JiraUnknownIssueNumberError < StandardError ; end
    class JiraAlreadyExistsError < StandardError ; end

    attr_accessor :sfdcid, :campaign_order, :jira, :fields, :description

    def initialize(campaign_order)
      @co       = campaign_order
      @sfdcid   = @co.sfdcid
      @fields   = Value::Field.new
      @jira_key = @co.jira_key
      @jira     = Jira::Issue.find_by_key(@jira_key) unless @jira_key.nil?
    end

    def find_or_create_jira_by_campaign_order
      return false unless @co
      @jira = Jira::Issue.find_or_create_by_campaign_order(@co,self.subject)
      binding.pry
      @jira_key = @jira.key
      @co.jira_key = @jira_key
      @co.save
      @jira
    end

    def import_from_campaign_order
      @jira = find_or_create_jira_by_campaign_order if @jira.nil?
      # second test: if still no JIRA then fail
      fail JiraUnknownIssueNumberError, @sfdcid.to_s if @jira.nil?
      fail JiraAlreadyExistsError, @jira_key if @jira.pre_imported?

      Rails.logger.level=Logger::INFO
      import_matched_fields
      Rails.logger.info 'Imported matched fields'
      import_tables
      Rails.logger.info 'Imported tables'
      import_attachments
      Rails.logger.info 'Imported attachments'
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
      Rails.logger.level=Logger::DEBUG
      attmts = @co.attachments.select { |a| a.created_at > 7.days.ago }
      attmts.each do |a|
        @jira.attach_file(a)
      end
      Rails.logger.level=Logger::INFO
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
