Rails.application.routes.draw do


  namespace :admin do
    resources :books, only: [:index]
  end

end
