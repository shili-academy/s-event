Rails.application.routes.draw do
  # devise_for :admins
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "static_pages#home"
    as :user do
      get "signin" => "devise/sessions#new"
      post "signin" => "devise/sessions#create"
      delete "signout" => "devise/sessions#destroy"
    end

    resources :events do
      resources :tasks
    end

    namespace :admin do
      root "admins#index"
      resources :events
      resources :topics do
        resources :tasks
      end
    end
  end
end
