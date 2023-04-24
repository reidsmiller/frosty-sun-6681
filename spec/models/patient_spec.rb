require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'relationships' do
    it { should have_many :doctor_patients }
    it { should have_many(:doctors).through(:doctor_patients) }
    it { should have_many(:hospitals).through(:doctors) }
  end

  describe 'instance methods' do
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

    describe '#find_doctor_patient' do
      it 'can return the doctor_patient object for a doctor and patient' do
        expect(@patient1.find_doctor_patient(@doctor1)).to eq(@doctor_patient1)
        expect(@patient2.find_doctor_patient(@doctor1)).to eq(@doctor_patient2)
      end
    end
  end

  describe 'class methods' do
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

    describe '.all_adults_by_name' do
      it 'can return all patients over 17 sorted by name' do
        expect(Patient.all_adults_by_name).to eq([@patient5, @patient2, @patient1, @patient3])
      end
    end
  end
end