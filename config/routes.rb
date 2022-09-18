Rails.application.routes.draw do
  root 'welcomes#index'

  namespace 'homepages' do
    match 'brands/autocomplete' => 'brands#autocomplete', via: :get
  end
  match 'users/autocomplete' => 'users#autocomplete', via: :get
  resources :users, only: %i[index show create update destroy] do

  end
  match 'users/:id/recover' => 'users#recover', via: %i[put patch]
  match 'users/:id/images' => 'users#images', via: %i[put patch]

  # Devise overrides
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    token_validations: 'overrides/token_validations',
    sessions: 'overrides/sessions',
    passwords: 'overrides/passwords'
  }

end