Rails.application.routes.draw do
  root to: 'todo_items#index'
  resources :todo_items
end
