class PatientsChgLanguageEthnicityRace < ActiveRecord::Migration
  def change
    remove_column :patients, :race
    remove_column :patients, :ethnicity
    remove_column :patients, :preferred_language

    add_column :patients, :race_id, :integer
    add_column :patients, :ethnicity_id, :integer
    add_column :patients, :language_id, :integer

    add_foreign_key(:patients, :races)
    add_foreign_key(:patients, :ethnicities)
    add_foreign_key(:patients, :languages)
  end
end
