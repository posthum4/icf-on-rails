module Service
  class CampaignOrderImporter

    attr_accessor :sfdcid, :opportunity, :jira

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @opportunity = SalesForce::Opportunity.find(sfdcid)
      #@jira = find_or_create_jira_by_sfdcid
    end

    def import
      return false unless @opportunity
      return false unless @sfdcid
      f = Value::Field.new
      description(f)


      # Field.present_in_order.each do |f|
      #   @order[f.name_in_order] = @opportunity[f.name_in_oppt]
      # end

    end

    private

    def description(fields)
      description = ""
      fields.for_description.each do |h|
        label = h.keys[0]
        sflabel = h.values[0]
        v = @opportunity[sflabel]
        unless v.nil?
          if v.respond_to?(:to_str)
            if v.include? "\n"
              description << "\n #{label.upcase}\n#{[v]}\n\n"
            else
              description << "#{label}: #{v}\n"
            end
          end
        end
      end
      description
    end



  end
end
