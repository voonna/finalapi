Rails.application.routes.draw do
  resources :patients do
    member do
      get :appointments
    end
  end
  resources :doctors do
    member do
      get :appointments
    end
  end
  resources :appointments
  get '/appointments/doctor/:doctor_id/patient/:patient_id' => 'appointments#by_doctor_and_patient'
  get '/appointments/date/:date' => 'appointments#by_date'
end
