# frozen_string_literal: true

Rails.application.routes.draw do
  match 'current_user' => 'current_users#show', via: :get
  match 'current_user' => 'current_users#update', via: %i[put patch]
  match 'current_user/images' => 'current_users#images', via: %i[put patch]
end
