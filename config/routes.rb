Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "static_pages#index"
    get "static_pages/about"
    get "static_pages/help"
    as :user do
      post "signin" => "devise/sessions#create"
      delete "signout" => "devise/sessions#destroy"
    end
    resources :users do
      collection do
        get :signin
        get :signup
      end
    end
    resources :events do
      resources :tasks
    end

    namespace :admin do
      root "admins#index"
      resources :events
      resources :users
      resources :stories
      resources :topics do
        resources :tasks
      end
    end
  end
end
