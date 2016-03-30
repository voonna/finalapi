class AppointmentsController < ApplicationController
  def index
    respond_to do |f|
      f.json do
        render json: {
          appointments: Appointment.appointments_hash
        }
      end
    end
  end

  def create
    appointment = Appointment.create app_params
    respond_to do |f|
      f.json do
        if appointment.persisted?
          render json: {
            appointment: appointment.hash_view
          }
        else
          render json: {
            errors: appointment.errors
          }, status: 400
        end
      end
    end
  end

  def update
    appointment = Appointment.find(params[:id])
    is_updated = appointment.update(app_params)
    respond_to do |f|
      f.json do
        if is_updated
          render json: {
            appointment: appointment.hash_view
          }
        else
          render json: {
            errors: appointment.errors
          }, status: 400
        end
      end
    end
  end

  def destroy
    Appointment.find(params[:id]).destroy
    respond_to do |f|
      f.json do
        render json: {}, status: 200
      end
    end
  end

  def show
    appointment = Appointment.find(params[:id])
    respond_to do |f|
      f.json do
        render json: {
          appointment: appointment.hash_view
        }
      end
    end
  end

  def by_date
    respond_to do |f|
      f.json do
        render json: {
          appointments: Appointment.by_date(Time.parse(params[:date]))
        }
      end
    end
  end

  def by_doctor_and_patient
    respond_to do |f|
      f.json do
        render json: {
          appointments: Appointment.by_doctor_and_patient(params[:doctor_id], params[:patient_id])
        }
      end
    end
  end

  private

  def app_params
    params.require(:appointment).permit(
      :doctor_id,
      :patient_id,
      :description,
      :app_date
    )
  end
end
