Rails.application.routes.draw do

  resources :movies, except: [:edit, :update, :destroy]

  devise_for :users, :skip => [:sessions]
  as :user do
    get    "/login"  => "devise/sessions#new",     :as => :new_user_session
    post   "/login"  => "devise/sessions#create",  :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  root  "static_pages#home"

end
