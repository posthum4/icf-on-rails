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
        Rails.logger.info "#{m.from} #{m.subject}"
        process_message(m)
      end
    end

    def process_message(m)
      sfdcid = m.sfdcid
      Rails.logger.info "SFDCID = #{sfdcid}"
      begin
        i = ::Importer.new(sfdcid,m.msgid).import
      rescue Exceptions::OpportunityAlreadyImportedLocallyAndNotForcedError => e
        result = "This opportunity was already imported in the ICF database. (CO##{e.message})"
        co = CampaignOrder.find(e.message)
      rescue Exceptions::MissingSalesForceOpportunityID => e
        result = "Not a valid SalesForce Opportunity ID: SFDCID=#{e.message}"
        co = nil
      rescue Exceptions::JiraAlreadyExistsError => e
        puts "A JIRA for this opportunity already exists #{e.message}"
        return
      ensure
        #m.archive!
      end
      Rails.logger.info "#{result}"
      unless (!co || co.nil?)
        co.messageid = m.msgid
        co.result = result
        i.campaign_order = co
        i.export
      end
    end
  end
end
