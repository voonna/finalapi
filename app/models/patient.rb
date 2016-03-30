class Patient < ActiveRecord::Base
  has_many :doctors, through: :appointments
  has_many :appointments

  validates_presence_of :email
  validates_presence_of :phone

  def hash_view
    as_json(only: [:id, :first_name, :last_name, :email, :phone])
  end

  class << self
    def patients_hash
      Patient.all.map(&:hash_view)
    end
  end
end
