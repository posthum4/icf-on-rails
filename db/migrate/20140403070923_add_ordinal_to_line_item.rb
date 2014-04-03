class AddOrdinalToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :ordinal, :integer
  end
end
