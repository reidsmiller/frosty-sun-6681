class HospitalsController < ApplicationController
  def show
    @hospital = Hospital.find(params[:id])
    @doctors = @hospital.doctors.order_by_patient_count
  end
end