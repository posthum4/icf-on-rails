require 'csv'
module Value

  class IssueType

    def self.jira_id(opp_type_new__c)
      case opp_type_new__c
      when 'Media: New Business'
        19
      else
        19
      end

    end

  end
end
