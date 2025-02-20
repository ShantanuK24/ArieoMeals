Rails.application.routes.draw do
  namespace :admin do
    resources :daily_meal_records, only: [ :index ]

    resources :feedbacks, only: [ :index ]
  end

  # get "home/index"

  root "home#index"
  get "employees/dashboard"
  get "admins/dashboard"
  devise_for :users, controllers: {  registrations: "users/registrations",
  confirmations: "users/confirmations", sessions: "users/sessions", passwords: "users/passwords" }

  authenticate :user, ->(u) { u.admin? } do
    get "admin_dashboard", to: "admins#dashboard"
  end

  authenticate :user, ->(u) { u.employee? } do
    get "employee_dashboard", to: "employees#dashboard"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
