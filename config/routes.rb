# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :photos, param: :uuid, only: %i[index new create update destroy]
  resources :albums, param: :uuid, only: %i[index new create show destroy]

  root 'photos#index'
end
