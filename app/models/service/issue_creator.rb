module Service
  class IssueCreator

    attr_accessor :sfdcid, :campaign_order, :jira, :fields, :description

    def initialize(campaign_order,parent=false)
      @co       = campaign_order
      @sfdcid   = @co.sfdcid
      @fields   = Value::Field.new
      @jira_key = @co.jira_key
      @jira     = Jira::Issue.find_by_key(@jira_key) unless @jira_key.nil?
      @parent   = parent
    end

    def find_jira_by_campaign_order
      fail CampaignOrderMissing, @co if ( !@co || @co.nil? )
      @jira = Jira::Issue.find_by_campaign_order(@co) rescue nil
      unless @jira.nil? 
        @jira_key = @jira.key
        @co.jira_key = @jira_key
        @co.save
      end
      @jira
    end

    def create_jira_by_campaign_order
      fail CampaignOrderMissing, @co if ( !@co || @co.nil? )
      @jira = Jira::Issue.find_or_create_by_campaign_order(@co, self.subject)
      @jira_key = @jira.key
      @co.jira_key = @jira_key
      @co.save
      @jira
    end

    def import_from_campaign_order
      @jira = find_jira_by_campaign_order if @jira.nil?
      if !@jira.nil? and !@jira.key.nil? and @jira.key.starts_with?('ICF-')
        warn Warnings::JiraAlreadyExisted_NotOverwritten, "https://rocketfuel.jira.com/browse/#{@jira.key}"
      else
        @jira = create_jira_by_campaign_order
        # second test: if still no JIRA then fail
        fail Exceptions::JiraUnknownIssueNumberError, @sfdcid.to_s if @jira.nil?
        import_tables
        Rails.logger.info 'Imported tables'
        import_attachments
        Rails.logger.info 'Imported attachments'
        import_matched_fields
        Rails.logger.info 'Imported matched fields'
      end
      return @jira
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
      attmts = @co.attachments.select { |a| a.created_at > 7.days.ago }
      attmts.each do |a|
        @jira.attach_file(a)
      end
    end

    def subject
      if @parent
        result = "Original #{@co.name} [use as parent JIRA for IO changes]"
      else
        case @co.opp_type_new
        when 'Media: New Business', 'Enterprise: New Business'
          mymarker = 'Launch'
        else
          mymarker = 'Change'
        end
        result = "#{mymarker} #{@co.name} due #{@co.campaign_start_date}"
      end
    end

  end
end
