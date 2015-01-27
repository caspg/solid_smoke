Rails.application.routes.draw do

  resources :movies, except: [:edit, :update, :destroy]

  devise_for :users
  root  'static_pages#home'

end
