module Service
  class EmailProcessor

    def initialize(batch_size = 10)
      @mailbox = Gmail::Mailbox.new.inbox
      @batch_size = batch_size
    end

    def process_batch
      @mailbox[0..@batch_size].each do |m|
        process_message(m)
      end
    end

    def process_message(m)
    end
  end
end
end
