namespace :mailbox do
  task :import => :environment do
    Service::EmailProcessor.new().process_batch
  end
end

task :impexp, [:sfdcid] => [:environment] do |t, args|
  logger           = Logger.new(STDOUT)
  logger.level     = Logger::DEBUG
  Rails.logger     = logger
  Importer.new(args.sfdcid).importexport
end