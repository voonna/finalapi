class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor

  validates_presence_of :patient_id
  validates_presence_of :doctor_id
  validates_presence_of :description

  scope :by_date, ->(date) { 
    where('app_date between ? and ?', date.beginning_of_day, date.end_of_day)
  }

  scope :by_doctor_and_patient, ->(doctor_id, patient_id) {
    where(doctor_id: doctor_id, patient_id: patient_id)
  }

  def hash_view
    as_json(only: [:id, :doctor_id, :patient_id, :description, :app_date])
  end

  class << self
    def appointments_hash
      Appointment.all.map(&:hash_view)
    end
  end
end
