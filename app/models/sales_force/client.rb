module SalesForce
  class Client


    @@client = nil

    def initialize
      # singleton pattern: only one client per app
      if @@client.nil? then
        return false if !environment_set?
        @@client = Databasedotcom::Client.new(debug: true)
        return false if !authenticate
        return false if !materialize_all
      else
        @@client
      end
      @@client
    end

    def environment_set?
      verifier = true
      %w(CLIENT_ID CLIENT_SECRET USERNAME PASSWORD SECURITY_TOKEN).each do |v|
        verifier = ( verifier && !ENV["DATABASEDOTCOM_#{v}"].empty? )
      end
      return verifier
    end

    def materialize_all
      @@client.sobject_module = 'SalesForce'
      @@client.materialize("User")
      @@client.materialize("Account")
      @@client.materialize("Opportunity")
      @@client.materialize("Case")
      @@client.materialize("Attachment")
    end

    def client_id
      @@client.client_id
    end

    def client_secret
      @@client.client_secret
    end

    def http_get(request)
      @@client.http_get(request)
    end

    def authenticate
      password_concat = "#{ENV['DATABASEDOTCOM_PASSWORD']}#{ENV['DATABASEDOTCOM_SECURITY_TOKEN']}"
      result = @@client.authenticate :username => ENV['DATABASEDOTCOM_USERNAME'], :password => password_concat
      result ? @@client : result
    end
  end
end
