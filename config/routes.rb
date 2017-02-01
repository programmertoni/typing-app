Rails.application.routes.draw do

  root to: 'static_pages#index'
  get '/learn', to: 'static_pages#index'

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

  resources :books, only: [:index, :show] do
    resources :book_pages, only: [:show]
  end

  resources :languages, only: [:index] do
    resources :os_projects, only: [:index, :show] do
      resources :os_pages, only: [:show]
    end
  end
end
