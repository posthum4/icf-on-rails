module ViewModel
  class Description

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @opportunity = SalesForce::Opportunity.find(@sfdcid)
      @fields = Value::Field.new
      i = description
    end

    def description
      description = ""
      @fields.for_description.each do |h|
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

    def to_s
      description
    end
  end

end
