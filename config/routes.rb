Rails.application.routes.draw do


  get 'languages/index'

  namespace :admin do
    resources :books, only: [:index]
  end

end
