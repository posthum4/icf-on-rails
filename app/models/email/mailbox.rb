module Email
  class Mailbox

    @@client = nil

    def initialize
      @@client = Gmail.connect(ENV['GMAIL_USER'], ENV['GMAIL_PASS']) if @@client.nil?
      @messages = []
      @batch_size = ENV['EMAIL_BATCH_SIZE'].to_i
      @@client
    end

    def inbox
      @messages = []
      # Changed this simple line with workaround as per https://github.com/gmailgem/gmail/issues/160
      #tobeprocessed = @@client.inbox.emails(:unread)
      tobeprocessed = @@client.mailbox('[Gmail]/All Mail').emails(gm: 'in:inbox is:unread is:important') + @@client.mailbox('[Gmail]/All Mail').emails(gm: 'in:inbox is:unread !is:important')
      tobeprocessed[0..@batch_size].each do |msge|
      #@@client.mailbox('ICF/for_devt').emails.each do |msge|
        Rails.logger.info("#{msge.labels} #{msge.subject}")
        @messages << create_msg(msge)
      end
      @messages
    end

    def triggers
      @@client.inbox.emails(:all)
    end

    def test_msg
      @@client.emails(:all)
    end

    def errors
      @messages = []
      @@client.mailbox('ICF/for_devt').emails.each do |msge|
        @messages << create_msg(msge)
      end
      @messages
    end

    def create_msg(m)
      paramhash = {
        from:     m.from.first.mailbox + '@' + m.from.first.host,
        to:       m.to.first.mailbox + '@' + m.to.first.host,
        subject:  m.subject,
        date:     m.date.to_time,
        msgid:    m.message_id,
        gmailobj: m
      }
      Email::Message.new(paramhash)
    end

    def send_msg(msg)
      email = @@client.compose do
        to      "#{msg.to}"
        subject "#{msg.subject}"
        body    "#{msg.body rescue nil}"
      end
      Rails.logger.info "Prepared email #{email.from}=>#{email.to} #{email.subject}"
      email.deliver!
    end

  end
end
