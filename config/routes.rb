Rails.application.routes.draw do
  root to: 'boards#index', defaults: { locale: 'en' }

  scope '(:locale)', locale: /en|pt-BR/ do
    root to: 'boards#index', as: :locale_root

    resources :users

    resources :boards do
      resources :todo_items, except: :index do
        patch 'status' => 'todo_items/status#update', as: :status
      end
    end

    get 'login'             => 'sessions#new',    as: :login
    post '/sessions/create' => 'sessions#create', as: :create_session
    get '/sessions/destroy' => 'sessions#destroy', as: :destroy_session
  end

  namespace :api do
    namespace :v1 do
      resources :boards do
        resources :todo_items, only: %i[index show create update destroy]
      end
    end
  end
end
