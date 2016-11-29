namespace :mailbox do
  task :import => :environment do
    Service::EmailProcessor.new().process_batch
  end

  desc 'Send a simple test mail directly from rake' 
  task simpletest: :environment do
    Rails.logger.level = Logger::DEBUG
    ActionMailer::Base.mail(:from => "rocketfuelrobbie@gmail.com", :to => "roland@siebelink.org, dkras@rocketfuelinc.com", :subject => "test #{Time.now.strftime('%c')}", :body => "testing testing 123").deliver_now
  end
end

task :impexp, [:sfdcid] => [:environment] do |t, args|
  logger           = Logger.new(STDOUT)
  logger.level     = Logger::DEBUG
  Rails.logger     = logger
  Importer.new(args.sfdcid).importexport
end
