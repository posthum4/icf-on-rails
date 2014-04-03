class AddReferenceToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :campaign_order, index: true
  end
end
