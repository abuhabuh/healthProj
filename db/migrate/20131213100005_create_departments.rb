class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.belongs_to :health_care_provider, index: true

      t.timestamps
    end
  end
end
