class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.belongs_to :healthcare_provider, index: true

      t.timestamps
    end
  end
end
