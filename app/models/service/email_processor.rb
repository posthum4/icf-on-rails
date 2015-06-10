module Service
  class EmailProcessor


    def initialize(*args)
      @mailbox    = Email::Mailbox.new.inbox
      #@mailbox    = Email::Mailbox.new.errors
      @batch_size = ENV['EMAIL_BATCH_SIZE'].to_i
      @result     = ''
      @message    = ''
      @label      = ''
      @export     = nil
      @co         = nil
    end

    def process_batch
      @mailbox[0..@batch_size].each do |m|
        Rails.logger.info "#{m.from} #{m.subject}"
        Rails.logger.warn "This is a manual request!" if m.manual?
        begin
          importer = m.process
          if !importer.jira.nil? and importer.jira =~ /ICF\-\d+/
            Rails.logger.warn "Success: #{importer.jira}"
            answer_manual_success(importer.jira,m) if m.manual?
            m.move_to('ICF/imported')
          else
            Rails.logger.error "Fail: #{importer.jira}"
            answer_manual_error("Invalid JIRA ID or other, undefined error #{importer.inspect}",m) if m.manual?
            m.move_to('ICF/error')
          end
        rescue => err
          Rails.logger.error "Fail: #{err.inspect} \n #{err.backtrace}"
          report_error(err,m)
          answer_manual_error(err,m) if m.manual?
          m.move_to('ICF/error')
        ensure
          m.archive!
        end
      end
    end

    def report_error(error,message)
      error = "NilResultFromImport" if error.nil?
      co_best_guess = message.sfdcid rescue '#NULL'
      p = {
        to:         ENV['ERROR_MONITOR_ADDRESS'],
        subject:    "#{error.inspect}",
        body:       <<-ENDOFBODY
        Error:          #{error.inspect}
        Campaign Order: https://na6.salesforce.com/#{co_best_guess}
        Email subject:  #{message.subject}
        Email from:     #{message.from}
        Message ID:     #{message.msgid}

        #{error.backtrace}
        ENDOFBODY
      }
      m = Email::Message.new(p).send!
    end

    def answer_manual_success(result,message)
      _to      = "#{message.from}"
      _subject = "SUCCESS: #{message.subject}"
      _body    = "You have successfully generated a manual ICF JIRA:"
      _body    << "\n"
      _body    << "\n#{ENV['JIRA_API']}/browse/#{result}"
      _body    << "\n"
      _body    << "\nManual imports have a much higher chance of errors. Please do check everything"
      _body    << "\nextra carefully. Have a successful campaign launch!"
      answer_manual_general(_to,_subject,_body)
    end

    def answer_manual_error(result,message)
      _to      = "#{message.from}"
      _subject = "ERROR: #{message.subject}"
      _body    = "Your request generated the following error:"
      _body    << "\n"
      _body    << "\n#{result.inspect}"
      _body    << "\n"
      _body    << "\nPlease try again if it is clear what you can correct. "
      _body    << "\nIf not, you can ask your dedicated ICF Champion for help:"
      _body    << "\n"
      _body = _body + CHAMPIONS

      answer_manual_general(_to,_subject,_body)
    end

    def answer_manual_general(_to,_subject,_body)
      p = {
        to:         "#{_to}",
        subject:    "#{_subject}",
        body:       "#{_body}"
      }
      begin
        m = Email::Message.new(p).send!
      rescue => err
        Rails.logger.error "Failed to send email: #{err.inspect}"
      end
    end
  end
end
