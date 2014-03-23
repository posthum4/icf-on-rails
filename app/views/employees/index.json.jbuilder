json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :username, :function, :salesforce_user, :jira_user
  json.url employee_url(employee, format: :json)
end
