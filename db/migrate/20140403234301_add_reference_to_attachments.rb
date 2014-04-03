class AddReferenceToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :campaign_order, index: true
  end
end
