SalesForce::Client.new()
module SalesForce

  class Opportunity

    def compact
      delete_if {|k,v| v.nil? }
    end
 
  end
  
end
