require 'rails_helper'

RSpec.describe Doctor do
  describe 'relationships' do
    it { should belong_to :hospital }
    it { should have_many :doctor_patients }
    it { should have_many(:patients).through(:doctor_patients) }
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
     
      DoctorPatient.create!(doctor: @doctor1, patient: @patient1)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient2)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient3)
      DoctorPatient.create!(doctor: @doctor1, patient: @patient4)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient5)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient1)
      DoctorPatient.create!(doctor: @doctor2, patient: @patient2)
    end

    describe '#hospital_name' do
      it'can return the name of the hospital' do
        expect(@doctor1.hospital_name).to eq(@hospital.name)
        expect(@doctor2.hospital_name).to eq(@hospital.name)
      end
    end

    describe '#find_patients' do
      it 'can return all patients for a doctor' do
        expect(@doctor1.find_patients).to eq([@patient1, @patient2, @patient3, @patient4])
        expect(@doctor2.find_patients).to eq([@patient1, @patient2, @patient5])
      end
    end
  end

  describe 'class methods' do
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

    describe '.order_by_patient_count' do
      it 'can return doctors ordered by number of patients' do
        expect(Doctor.order_by_patient_count).to eq([@doctor1, @doctor4, @doctor3, @doctor2])
        expect(Doctor.order_by_patient_count.first.patient_count).to eq(4)
        expect(Doctor.order_by_patient_count.last.patient_count).to eq(1)
      end
    end
  end
end
