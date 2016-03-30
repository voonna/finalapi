class Doctor < ActiveRecord::Base
  has_many :patients, through: :appointments
  has_many :appointments
  
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :speciality

  def hash_view
    as_json(only: [:id, :first_name, :last_name, :email, :phone, :speciality])
  end

  class << self
    def doctors_hash
      Doctor.all.map(&:hash_view)
    end
  end
end
