class CreateUserSurgeonProfiles < ActiveRecord::Migration
  def change
    create_table :user_surgeon_profiles do |t|
      t.belongs_to :user
      t.belongs_to :surgeon_specialty

      t.timestamps
    end

    add_foreign_key(:user_surgeon_profiles, :surgeon_specialties)
    add_foreign_key(:user_surgeon_profiles, :users)
  end
end
