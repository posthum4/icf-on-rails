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
      r = @@table.select do |f|
        f['JIRA_direct']
      end
      CSV::Table.new(r).values_at('SalesForce','JIRA_field')
    end

    def description
      r = @@table.select do |f|
        f['JIRA_description']
      end
      CSV::Table.new(r).values_at('Label','SalesForce')
    end


  end
end
