Rails.application.routes.draw do
  get 'customers/welcome'

  devise_for :customers
  resources :bookings do
    collection do
      post 'check_availability'
      post 'reserve'
    end
  end

  devise_scope :customers do
    get '/dashboard' => 'customers#welcome', as: :customer_dashboard
  end
end
