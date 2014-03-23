module SalesForce

  class User

    def self.materialize(client)
      client.materialize("User")
    end

  end
end
