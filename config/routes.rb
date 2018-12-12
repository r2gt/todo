Rails.application.routes.draw do
  root to: 'todo_items#index', defaults: { locale: 'en' }

  scope '(:locale)', locale: /en|pt-BR/ do
    root to: 'todo_items#index', as: :locale_root

    resources :todo_items do
      resources :status, only: :create, controller: 'todo_items/status'
    end

    resources :users

    get 'login'             => 'sessions#new',    as: :login
    post '/sessions/create' => 'sessions#create', as: :create_session
    get '/sessions/destroy' => 'sessions#destroy', as: :destroy_session

  end

  namespace :api do
    namespace :v1 do
      resources :todo_items, only: [:index, :create, :update]
    end
  end
end
