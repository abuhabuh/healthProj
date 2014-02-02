class CreatePreopRiskAssessments < ActiveRecord::Migration
  def change
    create_table :preop_risk_assessments do |t|
      t.belongs_to :surgical_profile, index: true
      t.integer :bit_field
      # Stored as cm: max ~30 ft
      t.decimal :height, :precision => 7, :scale => 4
      # Stored as kg: max ~2.2K lbs
      t.decimal :weight, :precision => 7, :scale => 4
      t.integer :diabetes_mellitus
      t.integer :functional_health_status
      t.integer :sepsis_within_48hrs

      t.timestamps
    end

    add_foreign_key(:preop_risk_assessments, :surgical_profiles)
  end
end
