require 'csv'
module Value

  class Field < CSV::Table

    @@instance = nil
    @@table = nil

    def initialize
      @@table = CSV::read("#{Rails.root}/db/fields.csv", headers: true)
      @@instance = self
      @@instance
    end

    def jira_direct
      @@table.select { |f| f['JIRA_description'] == 'direct' }.to_a
    end

    def for_description
      r = []
      list = @@table.select do|f|
#        (f['Object'] == 'CampaignOrder' && f['JIRA'] == 'description' )
        (f['Object'] == 'CampaignOrder' )
      end
      list.each do |i|
        r << { i['Label'] => i['SalesForce'] }
      end
      r
    end


  end
end
