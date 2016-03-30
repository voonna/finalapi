class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.text :description
      t.datetime :app_date
      t.references :patient, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
