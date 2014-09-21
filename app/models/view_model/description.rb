module ViewModel
  class Description
    # TODO: 2014-04-05 redo this on the basis of campaign_order

    def initialize(campaign_order)
      # @sfdcid = sfdcid
      # @opportunity = SalesForce::Opportunity.find(@sfdcid)
      @co = campaign_order
      @fields = Value::Field.new
      i = description
    end

    def general_info
      data_string = ''
      @fields.description.each do |a|
        label,cofield = a
        # TODO: 2014-04-01 write a nicer formatter for non-string fields
        v = @co[cofield]
        unless v.blank? or v == 'No' or v == 'NO BRAND SAFETY PRODUCT'
          # if v.include? "\n"
          #   data_string << "\n\n #{label.upcase}\n#{[v]}\n\n"
          # else
          if v =~ /0068000000/ || v=~ /5008000000/
            data_string << "|#{label} | https://na6.salesforce.com/#{v} |\n"
          else
            data_string << "|#{label} | #{v} |\n"
          end
        end
      end
      data_string << "|ICF version |#{VERSION} |\n"
    end

    def description
      descr = ''
      descr << ENV['DESCR_PREFIX'] || ''
      descr << "\n\n"
      descr << general_info
      descr << "\n"
      descr << ENV['DESCR_SUFFIX'] || ''
    end

    def to_s
      description
    end
  end

end
