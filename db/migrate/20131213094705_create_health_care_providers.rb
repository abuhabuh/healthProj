class CreateHealthCareProviders < ActiveRecord::Migration
  def change
    create_table :healthcare_providers do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
