# encoding: utf-8

namespace :service do
  namespace :email_processor do
    task :import => :environment do
      Service::EmailProcessor.new().process_batch
    end
  end
end
