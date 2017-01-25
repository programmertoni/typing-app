Rails.application.routes.draw do

  get 'languages/index'

  namespace :admin do
    resources :books, only: [:index, :create, :edit, :update, :destroy] do
      resources :book_pages, only: [:index, :new, :create, :edit, :update, :destroy]
    end
  end

end
