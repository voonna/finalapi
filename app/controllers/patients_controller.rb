class PatientsController < ApplicationController
  def create
    patient = Patient.create(patient_params)
    respond_to do |f|
      f.json do 
        if patient.persisted?
          render json: {
            patient: patient.hash_view
          }
        else
          render json: {
            errors: patients.errors
          }, status: 400
        end
      end
    end
  end

  def index
    respond_to do |f|
      f.json do 
        render json: {
          patients: Patient.patients_hash
        }
      end
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    respond_to do |f|
      f.json do 
        render json: {}, status: 200
      end
    end
  end

  def update
    @patient = Patient.find(params[:id])
    is_updated = @patient.update(patient_params)
    respond_to do |f|
      f.json do
        if is_updated
          render json: {
            patient: @patient.hash_view
          }
        else
          render json: {
            errors: @patient.errors
          }, status: 400
        end
      end
    end
  end

  def show
    @patient = Patient.find(params[:id])
    respond_to do |f|
      f.json do 
        render json: {
          patient: @patient.hash_view
        }
      end
    end
  end

  def appointments
    @patient = Patient.find(params[:id])
    respond_to do |f|
      f.json do 
        render json: {
          appointments: @patient.appointments.map(&:hash_view)
        }
      end
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :first_name,
      :last_name,
      :email,
      :phone
    )
  end
end
