class ChangeBrandSafetyNotesToText < ActiveRecord::Migration
  def up
    change_column :campaign_orders, :brand_safety_notes, :text
  end
  def down
    change_column :campaign_orders, :brand_safety_notes, :string
  end
end
