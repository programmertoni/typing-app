Rails.application.routes.draw do

  get 'languages/index'

  namespace :admin do
    resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
      resources :book_pages, only: [:create, :new]
    end
  end

end
