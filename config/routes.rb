# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :photos, only: %i[index new create destroy]
  resources :albums, param: :uuid, only: %i[index new create show destroy]

  root 'photos#index'
end
