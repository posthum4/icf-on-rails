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
      result = ::Importer.new(sfdcid).import_and_export
      Rails.logger.level "result = #{result}"
    end
  end
end
