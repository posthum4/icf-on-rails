module Service
  class IssueCreator

    class JiraAlreadyExistsError < StandardError ; end

    def initialize(order)
      @order = order
      @sfdcid = order.sfdcid
    end

    def import
      return false unless @order
      return false unless @sfdcid
      if existing_key.nil?
        t = Value::IssueType.jira_id(Order.type)
        Jira::Issue.create!(t)
      else
        fail JiraAlreadyExistsError, "A Jira with this Opportunity ID already exists: #{existing_key}"
      end
    end

    def existing_key
      i = Jira::Issue.find_by_sfdcid(@sfdcid)
      i.size > 0 : i.first.key : nil
    end

    def order_type
      "New Business"
    end


  end

end

# Value::Field.present_in_order.each do |f|
#   @order[f.name_in_order] = @opportunity[f.name_in_oppt]
# end
