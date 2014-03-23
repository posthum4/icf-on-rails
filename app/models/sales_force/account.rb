module SalesForce

  class Account

    def self.materialize(client)
      client.materialize("Account")
    end

  end

end
