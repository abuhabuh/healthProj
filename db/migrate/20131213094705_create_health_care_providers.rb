class CreateHealthCareProviders < ActiveRecord::Migration
  def change
    create_table :health_care_providers do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
