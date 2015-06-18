require 'databasedotcom'

# test 1 - new client id/secret with my production account
#puts "\n\nTEST 1:\n"


userids = %w( externalappuser@rocketfuel.com externalappuser@rocketfuel.com.full roland@rocketfuel.com roland@rocketfuel.com.full )
passwords = {'roland'=>%w\ tgb0y?Qatar2n8B1sNDt75BZdtcaRBHZ8Md tgb0y?QatarL9WdHbvVszoZEUFSbwmrOvTc \, 'externalappuser' => %w\ RocketFuelApp19002n8B1sNDt75BZdtcaRBHZ8Md RocketFuelApp1900L9WdHbvVszoZEUFSbwmrOvTc \}
# puts userids.inspect
# puts passwords.inspect

userids.each do |userid|
  identifier = userid[/[^@]+/]
  #puts "#{userid}, #{identifier}"
  passwords[identifier].each do |password|
    puts "\n#{userid} #{password}"
    client = Databasedotcom::Client.new :client_id => "3MVG9PerJEe9i8iKookjMaMTE6auO4lzf8dF0vSztEMUtVbVtlFm6nDGqiNQZD31pCIgDp_UkipYkXcb0sXi7", :client_secret => "8828031521392913569", :host => "test.salesforce.com"
    puts "CLIENT:\n#{client.inspect}"
    begin
      access = client.authenticate :username => userid, :password => password
    rescue Databasedotcom::SalesForceError
      access = "Authentication error"
    end
    puts "ACCESS:\n#{access.inspect}"
    access = nil
    #puts "ACCESS:\n#{access.inspect}"
    client = nil
    #puts "CLIENT:\n#{client.inspect}"
  end
end
abort
