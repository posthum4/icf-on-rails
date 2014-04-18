class ChangeImpressionsToBigInt < ActiveRecord::Migration
  def up
    change_column :line_items, :impressions, :integer, :limit => 8
  end
  def down
    change_column :line_items, :impressions, :integer, :limit 
  end
end
