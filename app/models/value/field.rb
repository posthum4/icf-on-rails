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
      r = @@table.select { |f| f['JIRA_direct'] }
      CSV::Table.new(r).values_at('Internal','JIRA_field')
    end

    def jira_set_type(jira_field)
      # get the row with the right JIRA field
      r = @@table.select { |f| f['JIRA_field'] == jira_field }
      # return the JIRA_set_special column
      CSV::Table.new(r).values_at('JIRA_set_special').join
    end

    def description
      r = @@table.select { |f| f['JIRA_description'] }
      CSV::Table.new(r).values_at('Label','SalesForce')
    end

    def from_oppt_to_co
      r = @@table.select { |f| f['Object'] == 'CampaignOrder' }
      CSV::Table.new(r).values_at('SalesForce','Internal')
    end


  end
end
