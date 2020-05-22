Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  # get  '/recipes', to: 'recipes#index'
  # get 'recipes/new', to: 'recipies#new'
  # get 'recipes/:id', to: 'recipes#show', as: 'recipe'

  resources :recipes

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]


end
