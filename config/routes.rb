Rails.application.routes.draw do
  resources :todo_items, only: [:index, :new, :create, :show, :edit, :update]
end
