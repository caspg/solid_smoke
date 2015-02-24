Rails.application.routes.draw do

  resources :movie_ratings, only: [:create, :update]

  resources :comments, only: [:create, :destroy]

  resources :reviews, only: [:create, :destroy] do 
    member { post :vote }
  end

  resources :movies, except: [:edit, :update, :destroy] do
    collection do  
      get "/search-info" => "movies#search_info"
      get "/get-info"    => "movies#get_info"
    end
  end

  devise_for :users, :skip => [:sessions]
  as :user do
    get    "/login"  => "devise/sessions#new",     :as => :new_user_session
    post   "/login"  => "devise/sessions#create",  :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  root  "static_pages#home"

end
