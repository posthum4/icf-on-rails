class AddAdFormatToLineItemObject < ActiveRecord::Migration
  def change
        add_column :line_items, :ad_format, :string
  end
end
