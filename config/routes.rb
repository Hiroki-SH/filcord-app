Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/film/export', to: 'films#film_export'

  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :films, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :photos, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :user #単数系リソースの使用
  resource :password, only: [:edit, :update]
end
