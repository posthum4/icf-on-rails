module Service
  class EmailProcessor

    def initialize(*args)
      @mailbox    = Email::Mailbox.new.inbox
      @batch_size = ENV['EMAIL_BATCH_SIZE'].to_i
    end

    def process_batch
      Rails.logger.level = Logger::INFO
      @mailbox[0..@batch_size].each do |m|
        process_message(m)
      end
    end

    def process_message(m)
      sfdcid = m.sfdcid

      begin
        result = ::Importer.new(sfdcid).import_and_export
        campaign_order = result.campaign_order
        campaign_order.messageid = m.message_id
      rescue ::Importer::JiraForThisOpportunityAlreadyCreatedError => e
        result = "A JIRA for this opportunity already exists #{e.message}"
      rescue Service::IssueCreator::JiraAlreadyExistsError => e
        result = "A JIRA for this opportunity already exists #{e.message}"
      ensure
        Rails.logger.info "result = #{result}"
        campaign_order.result = result
      end
    end
  end
end
