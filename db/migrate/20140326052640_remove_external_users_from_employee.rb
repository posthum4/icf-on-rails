class RemoveExternalUsersFromEmployee < ActiveRecord::Migration
  def change
    remove_column :employees, :salesforce_user
    remove_column :employees, :jira_user
  end
end
