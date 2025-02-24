Rails.application.routes.draw do
    root "home#index"

    devise_for :users, controllers:
    {
      registrations: "users/registrations",
      confirmations: "users/confirmations",
      sessions: "users/sessions",
      passwords: "users/passwords"
    }

    namespace :employee do
      resources :daily_meal_records, only: [ :index, :new, :create ]
      resources :feedbacks, only: [ :new, :create ] do
        collection do
          get "no_feedback"
        end
      end
    end

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :daily_meal_records, only: [ :index ]

    resources :feedbacks, only: [ :index ]
  end

  get "employees/dashboard"
  get "admins/dashboard"


  authenticate :user, ->(u) { u.admin? } do
    get "admin_dashboard", to: "admins#dashboard"
  end

  authenticate :user, ->(u) { u.employee? } do
    get "employee_dashboard", to: "employees#dashboard"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
