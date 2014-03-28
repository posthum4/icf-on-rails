Jiralicious.configure do |config|
  config.username =     ENV['JIRA_USER']
  config.password =     ENV['JIRA_PASS']
  config.uri =          ENV['JIRA_API']
  config.api_version = 'latest'
  config.auth_type =   :basic
end
