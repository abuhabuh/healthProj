class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.belongs_to :user, index: true
      t.belongs_to :role, index: true

      t.timestamps
    end

    add_foreign_key(:user_roles, :users)
    add_foreign_key(:user_roles, :roles)
  end
end
