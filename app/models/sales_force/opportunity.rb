module SalesForce

  class Opportunity
 
    def self.materialize(client)
      client.materialize("Opportunity")
    end

  end
  
end
