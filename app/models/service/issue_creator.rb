module Service
  class IssueCreator

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @order = Order.find_or_create_by(sfdcid: sfdcid)
      @order.jira_key = find_or_create_jira_by_sfdcid
    end

    def find_or_create_jira_by_sfdcid
      return false unless @order
      return false unless @sfdcid
      if existing_key.nil?
        t = Value::IssueType.jira_id(Order.type)
        jira_key = Jira::Issue.create!(t)
      else
        jira_key = existing_key
      end
    end

    def existing_key
      i = Jira::Issue.find_by_sfdcid(@sfdcid)
      i.size > 0 ? i.first.key : nil
    end

  end

end

# Value::Field.present_in_order.each do |f|
#   @order[f.name_in_order] = @opportunity[f.name_in_oppt]
# end
