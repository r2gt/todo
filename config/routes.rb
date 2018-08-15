Rails.application.routes.draw do
  root to: 'todo_items#index', defaults: { locale: 'en' }

  scope '(:locale)', locale: /en|pt-BR/ do
    root to: 'todo_items#index', as: :locale_root
    resources :todo_items
    resources :users

    get 'login'             => 'sessions#new',    as: :login
    post '/sessions/create' => 'sessions#create', as: :create_session
  end
end
