Rails.application.routes.draw do
  root "home#index"

  get "employees/dashboard"
  get "admins/dashboard"
  devise_for :users, controllers: { registrations: "users/registrations",
  confirmations: "users/confirmations", sessions: "users/sessions", passwords: "users/passwords" }

  authenticate :user, ->(u) { u.admin? } do
    get "admin_dashboard", to: "admins#dashboard"
  end

  authenticate :user, ->(u) { u.employee? } do
    get "employee_dashboard", to: "employees#dashboard"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
