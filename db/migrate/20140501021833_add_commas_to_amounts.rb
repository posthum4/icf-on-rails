class AddCommasToAmounts < ActiveRecord::Migration
  def up
    change_column :campaign_orders, :amount, :decimal, :precision => 10, :scale => 2
    change_column :line_items, :amount, :decimal, :precision => 10, :scale => 2
    change_column :line_items, :cost, :decimal, :precision => 10, :scale => 2
  end
  def down
    change_column :campaign_orders, :amount, :decimal, :precision => 10, :scale => 0
    change_column :line_items, :amount, :decimal, :precision => 10, :scale => 0
    change_column :line_items, :cost, :decimal, :precision => 10, :scale => 0
  end
end
