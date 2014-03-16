class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :add_on
      t.decimal :amount
      t.integer :bonus_impressions
      t.decimal :cost
      t.text :flight_instructions
      t.string :goal
      t.integer :impressions
      t.string :io_line_item
      t.string :media_channel
      t.string :pricing_term
      t.string :product
      t.string :secondary_optimization_goal
      t.belongs_to :order
      t.timestamps

    end
  end
end
