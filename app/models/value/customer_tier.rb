module Value

  class CustomerTier

    def self.jira_id(customer_tier_value)
      case customer_tier_value
      when 'Pivotal'
        '13893'
      when 'Standard'
        '13894'
      when 'Scale'
        '13895'
      else
        '17880'
      end
    end

  end
end
