class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.integer :country_id

      t.timestamps
    end

    add_foreign_key(:languages, :countries)
  end
end
