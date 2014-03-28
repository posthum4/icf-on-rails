require 'csv'
module Value

  class IssueType

    def self.jira_id(symbol)
      case symbol
      when :launch
        19
      when :io_change
        nil #tbd
      else
        nil
      end

    end

    def self.symbol_for(jira_id)
      case jira_id
      when 19
        :launch
      else
        nil
      end
    end

  end
end
