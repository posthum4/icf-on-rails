module Email
  class Message

    attr_accessor :subject, :from, :to, :date, :msgid

    def initialize(m)
      #@envelope = m.envelope
      @subject   = m.subject
      @from      = m.from.first.mailbox + '@' + m.from.first.host
      @to        = m.to.first.mailbox + '@' + m.to.first.host
      @date      = m.date.to_time
      @msgid     = m.message_id
      @gmailobj  = m
    end

    def sfdcid
      r = @subject.match (/0068000000\w{5}/)
      r.nil? ? false : r[0]
    end

    def archive!
      @gmailobj.archive!
    end

  end

end
