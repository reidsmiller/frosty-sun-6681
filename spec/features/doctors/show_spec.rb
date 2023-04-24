require 'rails_helper'

RSpec.describe 'Doctor Show Page', type: :feature do
  describe 'As a visitor, when I visit a doctors show page' do
    before(:each) do
      @hospital = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
      @doctor1 = @hospital.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
      @doctor2 = @hospital.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
      @patient1 = Patient.create!(name: 'Katie Bryce', age: 24)
      @patient2 = Patient.create!(name: 'Denny Duquette', age: 39)
      @patient3 = Patient.create!(name: 'Rebecca Pope', age: 32)
      @patient4 = Patient.create!(name: 'Zola Shepherd', age: 2)
      @patient5 = Patient.create!(name: 'Bunny Midge', age: 24)
     
      DoctorPatient.create!(doctor: @doctor1, patient: @patient1)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient2)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient3)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient4)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient5)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient1)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient2)
    end

    it 'I see all of that doctors information including: name, specialty, university where they got their doctorate, and the name of the hospital where they work' do
      visit doctor_path(@doctor1)

      expect(page).to have_content(@doctor1.name)
      expect(page).to have_content("Speciality: #{@doctor1.specialty}")
      expect(page).to have_content("University Attended: #{@doctor1.university}")
      expect(page).to have_content("Employed At: #{@hospital.name}")

      visit doctor_path(@doctor2)

      expect(page).to have_content(@doctor2.name)
      expect(page).to have_content("Speciality: #{@doctor2.specialty}")
      expect(page).to have_content("University Attended: #{@doctor2.university}")
      expect(page).to have_content("Employed At: #{@hospital.name}")
    end

    it 'I see the names of all of the patients this doctor has' do
      visit doctor_path(@doctor1)

      expect(page).to have_content('Patients:')
      expect(page).to have_content(@patient1.name)
      expect(page).to have_content(@patient2.name)
      expect(page).to have_content(@patient3.name)
      expect(page).to have_content(@patient4.name)

      visit doctor_path(@doctor2)

      expect(page).to have_content('Patients:')
      expect(page).to have_content(@patient5.name)
      expect(page).to have_content(@patient1.name)
      expect(page).to have_content(@patient2.name)
    end
  end
end