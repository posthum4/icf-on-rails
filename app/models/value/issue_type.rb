require 'csv'
module Value

# TODO: 2014-03-29 make this a pure mapping between internal symbols and JIRA types
# TODO: 2014-03-29 linking a opp_type_new__c to an issue type is the job of Policy::IssueTypeChooser
  class IssueType

    def self.jira_id(opp_type_new__c)
      case opp_type_new__c
      when 'New Business'
        "19"
      else
        "19"
      end

    end

  end
end
