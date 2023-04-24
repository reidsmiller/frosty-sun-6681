class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
  has_many :hospitals, through: :doctors

  def find_doctor_patient(doctor)
    doctor_patients.find_by(doctor_id: doctor.id)
  end

  def self.all_adults_by_name
    where('age >= ?', 18).order(name: :asc)
  end
end