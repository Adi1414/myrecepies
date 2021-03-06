Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
   # get 'pages/home', to: 'pages#home'
  # get  '/recipes', to: 'recipes#index'
  # get 'recipes/new', to: 'recipies#new'
  # get 'recipes/:id', to: 'recipes#show', as: 'recipe'

  resources :recipes do
  	resources :comments, only: [:create]
    resources :likes
  end	

  get '/signup', to: 'chefs#new'
  # get '/confirm_email/:id', to: 'chefs#confirm_email'

  resources :chefs, except: [:new] do
     member do
      get :confirm_email
    end
  end
 get '/login', to: 'sessions#new'
post '/login', to: "sessions#create"
delete '/logout', to: "sessions#destroy"

resources :ingredients, except: [:destroy]

mount ActionCable.server => '/cable'

get '/chat', to: 'chatrooms#show'
resources :messages, only: [:create]
end
