Rails.application.routes.draw do

  root                       to: 'static_pages#index'
  get  '/learn',             to: 'static_pages#index'
  get  '/login',             to: 'users#login'
  get  '/logout',            to: 'users#logout'
  post '/authenticate-user', to: 'users#user_authenticate'

  get  '/random-words',      to: 'random_words#show'
  get '/generate-random-words.json',  to: 'random_words#generate_sentance'

  resources :books, only: [:index, :show] do
    resources :book_pages, only: [:show]
  end

  resources :languages, only: [:index] do
    resources :os_projects, only: [:index, :show] do
      resources :os_pages, only: [:show]
    end
  end

  namespace :admin do
    resources :books, only: [:index, :create, :edit, :update, :destroy] do
      resources :book_pages, only: [:index, :new, :create, :edit, :update, :destroy]
    end

    resources :languages, only: [:index, :create, :edit, :update, :destroy] do
      resources :os_projects, only: [:index, :create, :edit, :update, :destroy] do
        resources :os_pages, only: [:index, :new, :create, :edit, :update, :destroy]
      end
    end
  end

end
