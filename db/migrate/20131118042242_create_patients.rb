class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :medical_record_id
      t.string :last_name
      t.string :first_name
      t.string :middle_initial
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :home_phone
      t.string :work_phone
      t.string :cell_phone
      t.date :date_of_birth
      t.string :gender
      t.string :race
      t.string :ethnicity
      t.string :preferred_language

      t.timestamps
    end
  end
end
