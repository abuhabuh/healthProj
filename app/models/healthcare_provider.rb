class HealthcareProvider < ActiveRecord::Base
  has_many :departments, dependent: :destroy

  validates_presence_of :name, :provider_type
end
