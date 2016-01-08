Rails.application.routes.draw do
  resources :users, only: [:show, :create, :update, :destroy] do
    resources :projects, only: [:index, :show, :create, :update, :destroy] do
      resources :pages, only: [:index]
    end
  end
end
