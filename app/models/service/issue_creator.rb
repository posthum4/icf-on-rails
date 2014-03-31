module Service
  class IssueCreator

    attr_accessor :sfdcid, :campaign_order, :jira

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @co = CampaignOrder.find_or_create_by(sfdcid: sfdcid)
      @jira = find_or_create_jira_by_sfdcid
    end

    def find_or_create_jira_by_sfdcid
      return false unless @co
      return false unless @sfdcid
      j = Jira::Issue.find_or_create_by_sfdcid(@sfdcid)
      @co.jira_key = j.key
      @co.save
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
