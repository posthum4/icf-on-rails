module Service
  class EmailProcessor


    def initialize(*args)
      Rails.logger.level = Logger::DEBUG
      @mailbox    = Email::Mailbox.new.inbox
      @batch_size = ENV['EMAIL_BATCH_SIZE'].to_i
      @result     = ''
      @message    = ''
      @label      = ''
      @export     = nil
      @co         = nil
      @co         = nil
    end

    def process_batch
      Rails.logger.level = Logger::INFO
      @mailbox[0..@batch_size].each do |m|
        Rails.logger.info "#{m.from} #{m.subject}"
        m.process
      end
    end

  end
end
