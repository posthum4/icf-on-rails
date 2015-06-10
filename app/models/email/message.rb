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
      @msgid    = p[:msgid].to_s
      @gmailobj = p[:gmailobj]
      @co       = nil
      @label    = nil
      @export   = nil
      @result   = nil
      @i        = nil
    end

    def process
      Rails.logger.info "Subject = #{subject}"
      @i                = ::Importer.new(self.sfdcid,@msgid).importexport
    end

    def sfdcid
      Policy::OpportunityID.validate(@subject)
    end

    def archive!
      @gmailobj.read!
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
