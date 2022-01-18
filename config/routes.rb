Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "static_pages#home"
    as :user do
      get "signin" => "devise/sessions#new"
      post "signin" => "devise/sessions#create"
      delete "signout" => "devise/sessions#destroy"
    end
  end
end
