class Departments < ActiveRecord::Base
  belongs_to :healthcare_provider

  validates_uniqueness_of scope: [:name, :healthcare_provider_id]
end
