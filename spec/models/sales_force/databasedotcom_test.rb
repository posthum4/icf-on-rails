#!/usr/bin/env ruby -KU

require 'databasedotcom'
client = Databasedotcom::Client.new :client_id => '3MVG9CVKiXR7Ri5qIMJmukfi1VVX5IH0CeMP1X01JLU_7ZUPwHM98pQJ.3bcummUt..cY37aI7dLcV.E7F6Zl', :client_secret => '6786622776677500118'

puts client.client_id

client.authenticate :username => 'roland@rocketfuel.com', :password =>  'tgb0y?Qatar2n8B1sNDt75BZdtcaRBHZ8Md'
#puts client.list_sobjects

client.materialize("Opportunity")
oppt = Opportunity.find('0068000000lOV8c')
puts "\n\n #{oppt.to_yaml}\n oppt = #{oppt.class}\n#{__FILE__}:#{__LINE__}"

