class AddInventoryTypeToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :inventory_type, :string
  end
end
