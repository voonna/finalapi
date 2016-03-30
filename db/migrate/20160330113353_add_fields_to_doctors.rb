class AddFieldsToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :email, :string
    add_column :doctors, :office, :string
    add_column :doctors, :phone, :string
    add_column :doctors, :speciality, :string
  end
end
