class AddUniqueConstraints < ActiveRecord::Migration
  def change
    add_index :patients, :medical_record_id, :unique => true
    add_index :countries, :name, :unique => true
    add_index :ethnicities, :name, :unique => true
    add_index :languages, :name, :unique => true
    add_index :races, :name, :unique => true
    add_index :departments, [:name, :healthcare_provider_id], :unique => true
  end
end
