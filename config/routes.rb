Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :films, [:show,:new, :create, :edit, :update, :destroy]
  resources :photos, only: [:show, :create, :edit, :update, :destroy]
  resource :user #単数系リソースの使用
end
