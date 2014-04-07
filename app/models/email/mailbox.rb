module Email
  class Mailbox

    @@client = nil

    def initialize
      @@client = Gmail.connect(ENV['GMAIL_USER'], ENV['GMAIL_PASS']) if @@client.nil?
      @messages = []
    end

    def inbox
      @messages = []
      @@client.inbox.emails.each do |m|
        @messages << Email::Message.new(m)
      end
      @messages
    end

    def triggers
      @@client.inbox.emails(:all)
    end

    def test_msg
      @@client.emails(:all)
    end

  end
end
