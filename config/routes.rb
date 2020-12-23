# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'postcode_checker#index'
  resources :postcode_checker, only: [:index]
end
