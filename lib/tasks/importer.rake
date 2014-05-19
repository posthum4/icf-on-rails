namespace :mailbox do
  task :import => :environment do
    Service::EmailProcessor.new().process_batch
  end
end

task :impexp, [:sfdcid] => [:environment] do |t, args|
  Importer.new(args.sfdcid).importexport
end