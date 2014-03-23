class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :username
      t.string :function
      t.has_one :salesforce_user
      t.has_one :jira_user

      t.timestamps
    end
  end
end
