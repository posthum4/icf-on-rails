module Service
  class IssueCreator

    attr_accessor :sfdcid, :order, :jira

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @order = Order.find_or_create_by(sfdcid: sfdcid)
      @jira = find_or_create_jira_by_sfdcid
    end

    def find_or_create_jira_by_sfdcid
      return false unless @order
      return false unless @sfdcid
      j = Jira::Issue.find_or_create_by_sfdcid(@sfdcid)
      @order.jira_key = j.key
      @order.save
      j
    end

    def jira_key
      @jira.key
    end

    # def existing_key
    #   i = Jira::Issue.find_by_sfdcid(@sfdcid)
    #   i.size > 0 ? i.first.key : nil
    # end

  end

end

# Value::Field.present_in_order.each do |f|
#   @order[f.name_in_order] = @opportunity[f.name_in_oppt]
# end
