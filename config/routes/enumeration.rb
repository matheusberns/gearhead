# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :enumerations do
    resources :brand_type, only: %i[index show]
  end
end
