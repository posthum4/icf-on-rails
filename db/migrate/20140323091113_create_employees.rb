class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :username
      t.string :function

      t.timestamps
    end
  end
end
