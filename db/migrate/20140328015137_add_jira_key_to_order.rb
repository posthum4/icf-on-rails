class AddJiraKeyToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :jira_key, :string
  end
end
