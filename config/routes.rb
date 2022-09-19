Rails.application.routes.draw do
  root 'welcomes#index'

  scope module: :homepages do
    match 'models/autocomplete' => 'models#autocomplete', via: :get
  end

  # Load others routes files
  draw(:admin)
  draw(:current_user)
  draw(:enumeration)

  # Regions
  resources :states, controller: 'regions/states', only: :index
  resources :cities, controller: 'regions/cities', only: :index

  # Cable
  mount ActionCable.server => '/cable'

  # Devise overrides
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    token_validations: 'overrides/token_validations',
    sessions: 'overrides/sessions',
    passwords: 'overrides/passwords'
  }
end