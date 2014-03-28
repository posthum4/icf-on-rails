class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :username
      t.string :function
      t.references :salesforce_user
      t.references :jira_user

      t.timestamps
    end
  end
end
