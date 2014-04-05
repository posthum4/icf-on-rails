class AddMoneyToCampaignOrdersAndLineItems < ActiveRecord::Migration
  def change
    add_money :campaign_orders, :budget, amount: { null: true, default: nil }, currency: { present: true }
    add_money :line_items, :budget, amount: { null: true, default: nil }, currency: { present: true}
    add_money :line_items, :price, amount: { null: true, default: nil }, currency: { present: false}
    rename_column :campaign_orders, :currencyisocode, :amount_currency
  end

end
