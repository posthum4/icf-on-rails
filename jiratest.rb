require 'jiralicious'

Jiralicious.configure do |config|
  # Leave out username and password
  config.username = "robbie"
  config.password = "KaiZenRocks!2015"
  config.uri = "http://jira.rocketfuel.com"
  config.api_version = "latest"
  config.auth_type = :basic
end

a = Jiralicious.search('key=ICF-52543')

puts a.inspect