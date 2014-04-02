json.array!(@campaign_orders) do |campaign_order|
  json.extract! campaign_order, :id, :sfdcid, :name, :jira_key
  json.url campaign_order_url(campaign_order, format: :json)
end
