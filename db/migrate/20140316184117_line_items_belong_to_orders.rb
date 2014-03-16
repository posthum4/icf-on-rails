class LineItemsBelongToOrders < ActiveRecord::Migration
  def change
    add_column :line_items do |t|
      t.integer :order_id
    end
  end
end