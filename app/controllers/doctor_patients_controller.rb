class DoctorPatientsController < ApplicationController
  def destroy
    doctor = Doctor.find(doctor_patient_params[:doctor_id])
    DoctorPatient.destroy(params[:id])
    redirect_to doctor_path(doctor)
  end

  private
  def doctor_patient_params
    params.require(:doctor_patient).permit(:doctor_id)
  end
end