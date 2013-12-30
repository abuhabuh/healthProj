class CreateSurgeonSpecialties < ActiveRecord::Migration
  def change
    create_table :surgeon_specialties do |t|
      t.string :name

      t.timestamps
    end
  end
end
