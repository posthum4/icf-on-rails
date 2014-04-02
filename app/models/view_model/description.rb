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
      @fields.description.each do |a|
        label = a[0]
        sflabel = a[1]
        # TODO: 2014-04-01 write a nicer formatter for non-string fields
        v = @opportunity[sflabel].to_s
        unless v.blank?
          if v.include? "\n"
            description << "\n #{label.upcase}\n#{[v]}\n\n"
          else
            description << "#{label}: #{v}\n"
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
