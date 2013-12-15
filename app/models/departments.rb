class Departments < ActiveRecord::Base
  belongs_to :health_care_provider

  validates_uniqueness_of scope: [:name, :health_care_provider_id]
end
