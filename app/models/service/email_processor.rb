module Service
  class EmailProcessor


    def initialize(*args)
      #      @mailbox    = Email::Mailbox.new.inbox
      @mailbox    = Email::Mailbox.new.errors
      @batch_size = ENV['EMAIL_BATCH_SIZE'].to_i
      @result     = ''
      @message    = ''
      @label      = ''
      @export     = nil
      @co         = nil
      @co         = nil
    end

    def process_batch
      @mailbox[0..@batch_size].each do |m|
        Rails.logger.info "#{m.from} #{m.subject}"
        r = m.process
        if r =~ /ICF\-\d+/
          Rails.logger.warn "Success: #{r}"
        else
          Rails.logger.error "Fail: #{r}"
          report_error(r,m)
        end
        puts r
      end
    end

    def report_error(error,message)
      # prepare an email to roland
      co_best_guess = error[:co] || message.sfdcid || #NULL
      p = {
        to:         ENV['ERROR_MONITOR_ADDRESS'],
        subject:    "#{co_best_guess} #{error[:msg]}",
        body:       <<-ENDOFBODY
        Error:          #{error[:msg]}
        Campaign Order: #{co_best_guess}
        Email subject:  #{error[:subject]}
        Email from:     #{error[:from]}
        Message ID:     #{message.msgid}
        ENDOFBODY
      }
      m = Email::Message.new(p).send!
    end

    def answer_manual_request
    end



  end
end
