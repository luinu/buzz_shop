require 'sidekiq/web'
Rails.application.routes.draw do

  devise_for :admins
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_facebook_user_session
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resource :user do
    collection do
      patch 'update_password'
      patch 'update_address'
    end
  end
  get 'zamowienia', to: 'users#show', as: 'orders', format: false
  get 'ustawienia-konta', to: 'users#settings', as: 'settings', format: false
  get 'adres', to: 'users#address', as: 'address', format: false
  resource :cart, controller: "cart", only: [:show, :update, :edit] do
    member do
      post :add_product
      post :remove_product
      get :confirmation
      post :finish
    end
  end

  namespace :admin do
    root to: 'products#index'
    resources :products
    resources :categories
    resources :orders, only: [:index, :show, :update]
    resources :users
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'regulamin' => 'static#terms', as: :terms
  get 'polityka-prywatnosci' => 'static#privacy', as: :privacy
  get 'dostawa' => 'static#shipping', as: :shipping
  get 'o-sklepie' => 'static#about', as: :about

  root to: "products#index"
  resources :products, only: [:show, :index], path: "produkt"
  resources :categories, only: [:show], path: "kategoria"

end
