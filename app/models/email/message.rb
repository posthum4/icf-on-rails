module Email
  class Message

    def initialize(m)
      binding.pry
      #@envelope = m.envelope
      @subject = m.subject
      @from = m.from.first.mailbox + '@' + m.from.first.host
      @to = m.to.first.mailbox + '@' + m.to.first.host
      @date = m.date.to_time
      @msgid = m.id
    end

    def sfdcid
      r = @subject.match (/0068000000\w{5}/)
      r.nil? ? false : r[0]
    end

  end

end
