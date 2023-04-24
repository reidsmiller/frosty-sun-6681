class PatientsController < ApplicationController
  def index
    @adult_patients = Patient.all_adults_by_name
  end
end