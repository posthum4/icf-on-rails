module Email
  class Message

    attr_accessor :subject, :from, :to, :date, :msgid, :body, :gmailobj, :co, :label

    # def initialize(m)
    #   #@envelope = m.envelope
    #   @subject   = m.subject
    #   @from      =
    #   @to        =
    #   @date      = m.date.to_time
    #   @msgid     = m.message_id
    #   @gmailobj  = m
    # end

    def initialize(p)
      @to       = p[:to]
      @from     = p[:from]
      @subject  = p[:subject]
      @date     = p[:date]
      @body     = p[:body]
      @msgid    = p[:msgid]
      @gmailobj = p[:gmailobj]
      @co       = nil
      @label    = nil
      @export   = nil
      @result   = nil
      @i        = nil
    end

    def process
      Rails.logger.info "SFDCID = #{sfdcid}"
      begin
        @i                = ::Importer.new(self.sfdcid,@msgid).import
        @co               = @i.campaign_order
        @co.messageid     = self.msgid
        @co.result        = @result
        @i.campaign_order = @co
        @i.export
        @label            = 'ICF/imported'
        @result           = @co.jira_key
      rescue => faultline
        Rails.logger.error faultline.inspect
        @result = {
          msg:      faultline,
          co:       @co,
          from:     @from,
          subject:  @subject
        }
        @label = 'ICF/error'
      ensure
        # unless @co.jira_key.nil?
        #   @result = @co.jira_key
        #   @label  = 'ICF/imported'
        # end
        Rails.logger.info "Ensuring labeling of the message as #{@label}..."
        self.move_to(@label)
        self.archive!
      end
      return @result
    end


    def sfdcid
      r = @subject.match (/0068000000\w{5}/)
      r.nil? ? false : r[0]
    end

    def archive!
      @gmailobj.archive!
    end

    def send!
      gmail = Email::Mailbox.new.send_msg(self)
    end

    def move_to(predefinedlabel)
      @gmailobj.add_label(predefinedlabel)
    end

    def manual?
      !@msgid.include? '@sfdc.net'
    end



  end

end
