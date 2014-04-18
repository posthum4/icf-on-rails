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
        Rails.logger.warn "This is a manual request!" if m.manual?
        r = m.process
        if r =~ /ICF\-\d+/
          Rails.logger.warn "Success: #{r}"
          answer_manual_success(r,m) if m.manual?
        else
          Rails.logger.error "Fail: #{r}"
          report_error(r,m)
          answer_manual_error(r,m) if m.manual?
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

    def answer_manual_success(result,message)
      _to      = "#{message.from}"
      _subject = "SUCCESS: #{message.subject}}"
      _body    = <<-ENDOFBODY1
      You have successfully generated a manual ICF JIRA:

        https://rocketfuel.jira.com/browse/#{result[:msg]}

      Manual imports have a much higher chance of errors.
        Please do check everything extra carefully.

            Have a successful campaign launch!
          ENDOFBODY1
          answer_manual_general(_to,_subject,_body)
        end

      def answer_manual_error(result,message)
        _to      = "#{message.from}"
        _subject = "ERROR: #{message.subject}}"
        _body    = <<-ENDOFBODY2
        Your request generated the following error:

          #{result[:msg]}

          Please try again or ask your local ICF Champion for help!
        ENDOFBODY2
        answer_manual_general(_to,_subject,_body)
      end

      def answer_manual_general(_to,_subject,_body)
        p = {to: _to, subject: _subject, body: _body}
        # overriding for testing
        #p[:to] =         ENV['AM_SUBSTITUTE_ADDRESS']
        m = Email::Message.new(p).send!
      end
    end
  end
