# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Add Ethnicity
Ethnicity.delete_all
Ethnicity.create!(:name => 'Hispanic')
Ethnicity.create!(:name => 'No')
Ethnicity.create!(:name => 'Unknown')

# Add Race
Race.delete_all
Race.create!(:name =>'White')
Race.create!(:name =>'Black/African American')
Race.create!(:name =>'American Indian/Alaska Native')
Race.create!(:name =>'Native Hawaiian/Other Pacific Islander')
Race.create!(:name =>'Asian')
Race.create!(:name =>'Unknown')

# Add Language
Language.delete_all
Language.create!(:name => 'English')
Language.create!(:name => 'Spanish')

# Add Countries
Country.delete_all  
=begin
open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries|  
  countries.read.each_line do |country|  
    code, name = country.chomp.split("|")  
    Country.create!(:name => name, :code => code)  
  end  
end
=end
Country.create!(:name=> 'United States', :code => 'US')
Country.create!(:name=> 'Canada', :code => 'CA')
Country.create!(:name=> 'China', :code => 'CN')

# Add Surgeon Specialties
SurgeonSpecialty.delete_all
SurgeonSpecialty.create!(:name=> 'General Surgery')
SurgeonSpecialty.create!(:name=> 'Vascular')
SurgeonSpecialty.create!(:name=> 'Thoracic')
SurgeonSpecialty.create!(:name=> 'Cardiac')
SurgeonSpecialty.create!(:name=> 'Orthopedics')
SurgeonSpecialty.create!(:name=> 'Neurosurgery')
SurgeonSpecialty.create!(:name=> 'Urology')
SurgeonSpecialty.create!(:name=> 'Otalarynology')
SurgeonSpecialty.create!(:name=> 'Plastics')
SurgeonSpecialty.create!(:name=> 'Gynecology')
SurgeonSpecialty.create!(:name=> 'Interventional Radiology')
