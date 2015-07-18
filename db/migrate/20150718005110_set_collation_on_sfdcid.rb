class SetCollationOnSfdcid < ActiveRecord::Migration
  def up
    execute("ALTER TABLE campaign_orders MODIFY `sfdcid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin;")
  end
  def down
    execute("ALTER TABLE campaign_orders MODIFY `sfdcid` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci;")
  end
end
