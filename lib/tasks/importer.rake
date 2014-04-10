namespace :mailbox do
  task :import => :environment do
    Service::EmailProcessor.new().process_batch
  end
end
