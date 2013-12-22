class Department < ActiveRecord::Base
  belongs_to :healthcare_provider

  validates_uniqueness_of :name, :scope => :healthcare_provider_id
end
