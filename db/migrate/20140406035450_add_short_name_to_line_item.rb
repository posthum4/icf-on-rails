class AddShortNameToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :shortname, :string
  end
end
