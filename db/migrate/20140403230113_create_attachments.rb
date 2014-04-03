class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :sfdcid
      t.string :name
      t.string :content_type
      t.binary :body

      t.timestamps
    end
  end
end
