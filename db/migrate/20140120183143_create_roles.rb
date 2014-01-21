###
# Description: Create roles rable
###

class CreateRoles < ActiveRecord::Migration
  def change
    remove_column :users, :role

    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
  end
end
