require 'rails_helper'

RSpec.describe 'Hospital Show Page', type: :feature do
  describe 'As a visitor, when I visit the hospital show page' do
    before(:each) do
      @hospital1 = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
      @hospital2 = Hospital.create!(name: 'Seaside Health & Wellness Center')
      @doctor1 = @hospital1.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
      @doctor2 = @hospital1.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
      @doctor3 = @hospital2.doctors.create!(name: 'Miranda Bailey', specialty: 'General Surgery', university: 'Stanford University')
      @doctor4 = @hospital1.doctors.create!(name: 'Derek McDreamy Shepherd', specialty: 'Attending Surgeon', university: 'University of Pennsylvania')
      @patient1 = Patient.create!(name: 'Katie Bryce', age: 24)
      @patient2 = Patient.create!(name: 'Denny Duquette', age: 39)
      @patient3 = Patient.create!(name: 'Rebecca Pope', age: 32)
      @patient4 = Patient.create!(name: 'Zola Shepherd', age: 2)
      @patient5 = Patient.create!(name: 'Bunny Midge', age: 24)

      @doctor_patient1 = DoctorPatient.create!(doctor: @doctor1, patient: @patient1)
      @doctor_patient2 = DoctorPatient.create!(doctor: @doctor1, patient: @patient2)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient3)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient4)
      DoctorPatient.create!(doctor: @doctor4, patient: @patient5)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient4)
      DoctorPatient.create!(doctor: @doctor3, patient: @patient1)
      DoctorPatient.create!(doctor: @doctor3, patient: @patient2)
      DoctorPatient.create!(doctor: @doctor4, patient: @patient2)
      DoctorPatient.create!(doctor: @doctor4, patient: @patient3)
    end

    it 'I see the hospitals name and the names of all doctars that work at this hospital' do
      visit hospital_path(@hospital1)

      expect(page).to have_content(@hospital1.name)
      expect(page).to have_content('Doctors:')
      expect(page).to have_content(@doctor1.name)
      expect(page).to have_content(@doctor2.name)
      expect(page).to_not have_content(@doctor3.name)

      visit hospital_path(@hospital2)

      expect(page).to have_content(@hospital2.name)
      expect(page).to have_content('Doctors:')
      expect(page).to have_content(@doctor3.name)
      expect(page).to_not have_content(@doctor1.name)
      expect(page).to_not have_content(@doctor2.name)
    end

    it 'next to each doctor I see the number of patients they have' do
      visit hospital_path(@hospital1)

      within("li#doctor_#{@doctor1.id}") do
        expect(page).to have_content('Number of Patients: 4')
      end

      within("li#doctor_#{@doctor2.id}") do
        expect(page).to have_content('Number of Patients: 1')
      end

      within("li#doctor_#{@doctor4.id}") do
        expect(page).to have_content('Number of Patients: 3')
      end

      visit hospital_path(@hospital2)

      within("li#doctor_#{@doctor3.id}") do
        expect(page).to have_content('Number of Patients: 2')
      end
    end

    it 'I see the list of doctors is ordered from most number of patients to least' do
      visit hospital_path(@hospital1)

      expect(@doctor1.name).to appear_before(@doctor4.name)
      expect(@doctor4.name).to appear_before(@doctor2.name)
    end
  end
end