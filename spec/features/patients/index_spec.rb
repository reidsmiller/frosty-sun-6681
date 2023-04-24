require 'rails_helper'

RSpec.describe 'Patient Index Page', type: :feature do
  describe 'As a visitor, when I visit the patient index page' do
    before(:each) do
      @hospital = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
      @doctor1 = @hospital.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
      @doctor2 = @hospital.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
      @patient1 = Patient.create!(name: 'Katie Bryce', age: 24)
      @patient2 = Patient.create!(name: 'Denny Duquette', age: 39)
      @patient3 = Patient.create!(name: 'Rebecca Pope', age: 32)
      @patient4 = Patient.create!(name: 'Zola Shepherd', age: 2)
      @patient5 = Patient.create!(name: 'Bunny Midge', age: 24)

      @doctor_patient1 = DoctorPatient.create!(doctor: @doctor1, patient: @patient1)
      @doctor_patient2 = DoctorPatient.create!(doctor: @doctor1, patient: @patient2)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient3)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient4)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient5)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient1)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient2)
    end

    it 'I see the names of all adult patients in asceding alphabetical order' do
      visit patients_path

      expect(page).to have_content('Patient Index Page')
      expect(page).to have_content('Adult Patients:')
      expect(@patient5.name).to appear_before(@patient2.name)
      expect(@patient2.name).to appear_before(@patient1.name)
      expect(@patient1.name).to appear_before(@patient3.name)
      expect(page).to_not have_content(@patient4.name)
    end
  end
end