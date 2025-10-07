Rails.application.routes.draw do
  namespace :api do
    resources :addresses, only: [:index, :show, :create, :destroy] do
      member do
        post :sync
        get :transactions
      end
    end
  end
end