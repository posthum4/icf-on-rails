module Service
  class EmailProcessor


    def initialize(*args)
      Rails.logger.level = Logger::DEBUG
      @mailbox    = Email::Mailbox.new.inbox
      @batch_size = ENV['EMAIL_BATCH_SIZE'].to_i
      @result     = ''
      @message    = ''
    end

    def process_batch
      Rails.logger.level = Logger::INFO
      @mailbox[0..@batch_size].each do |m|
        process_message(m)
      end
    end

    def process_message(m)
      sfdcid = m.sfdcid
      Rails.logger.info "SFDCID = #{sfdcid}"
      begin
        fail MissingSalesForceOpportunityIDError, sfdcid if sfdcid.nil?
        fail MissingEmailID, m.inspect if m.msgid.nil?
        r = ::Importer.new(sfdcid,m.msgid).import_and_export
        co = result.campaign_order
        co.messageid = m.message_id
      rescue Exceptions::JiraAlreadyExistsError => e
        result = "A JIRA for this opportunity already exists #{e.message}"
      end
      Rails.logger.info "result = #{result}"
      co.result = result
    end
  end
end
