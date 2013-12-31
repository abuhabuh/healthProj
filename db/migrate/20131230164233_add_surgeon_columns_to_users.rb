class AddSurgeonColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :role
      t.string :first_name
      t.string :last_name
      t.string :middle_initial
    end
  end
end
