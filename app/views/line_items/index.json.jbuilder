json.array!(@line_items) do |line_item|
  json.extract! line_item, :id, :add_on, :amount, :bonus_impressions, :cost, :flight_instructions, :goal, :impressions, :io_line_item, :media_channel, :pricing_term, :product, :secondary_optimization_goal
  json.url line_item_url(line_item, format: :json)
end
