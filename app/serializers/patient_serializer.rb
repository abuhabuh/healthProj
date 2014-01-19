class PatientSerializer < ActiveModel::Serializer
  # disable root element in returned json {"patient":{id:"1"...}}
  #   where "patient" is unnecessary root element
  self.root = false

  attributes :id,
             :medical_record_id,
             :date_of_birth,
             :last_name,
             :first_name,
             :middle_initial,
             :address1,
             :address2,
             :city,
             :state,
             :home_phone,
             :work_phone,
             :cell_phone,
             :gender,
             :race_id,
             :ethnicity_id,
             :language_id
end
