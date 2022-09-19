# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :admins do
    resources :users, only: %i[index show create update destroy]
    match 'users/autocomplete' => 'users#autocomplete', via: :get
    match 'users/:id/recover' => 'users#recover', via: %i[put patch]
    match 'users/:id/images' => 'users#images', via: %i[put patch]
  end
end
