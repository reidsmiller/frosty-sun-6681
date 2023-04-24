class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def hospital_name
    hospital.name
  end

  def find_patients
    patients
  end

  def self.order_by_patient_count
    joins(:patients).group(:id).select('doctors.*, COUNT(patients.id) AS patient_count').order('patient_count desc')
  end
end
