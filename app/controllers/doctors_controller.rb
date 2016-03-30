class DoctorsController < ApplicationController
  def create
    doctor = Doctor.create(doctor_params)

    respond_to do |f|
      f.json do
        if doctor.persisted?
          render json: {
            doctor: doctor.hash_view
          }
        else
          render json: {
            errors: doctor.errors
          }, status: 400
        end
      end
    end
  end

  def index
    respond_to do |f|
      f.json do 
        render json: {
          doctors: Doctor.doctors_hash
        }
      end
    end
  end

  def destroy
    Doctor.find(params[:id]).destroy
    respond_to do |f|
      f.json do
        render json: {}, status: 200
      end
    end
  end

  def update
    @doctor = Doctor.find(params[:id])
    is_updated = @doctor.update(doctor_params)
    respond_to do |f|
      f.json do
        if is_updated
          render json: {
            doctor: @doctor.hash_view
          }
        else
          render json: {
            errors: @doctor.errors
          }
        end
      end
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
    respond_to do |f|
      f.json do 
        render json: {
          doctor: @doctor.hash_view
        }
      end
    end
  end

  def appointments
    @doctor = Doctor.find(params[:id])
    respond_to do |f|
      f.json do 
        render json: {
          appointments: @doctor.appointments.map(&:hash_view)
        }
      end
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(
      :first_name,
      :last_name,
      :email,
      :office,
      :phone,
      :speciality
    )
  end
end
