Rails.application.routes.draw do
  devise_for :users
  resources :photos, only: %i[index create destroy]
end
