Rails.application.routes.draw do
  resources :users, only: [:show, :create, :update, :destroy] do
    resources :projects, only: [:index, :create, :update, :destroy]
  end
end
