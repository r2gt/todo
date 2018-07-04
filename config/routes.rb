Rails.application.routes.draw do
  root to: 'todo_items#index', defaults: { locale: 'en' }

  scope ':locale' do
    root to: 'todo_items#index', as: :locale_root
    resources :todo_items
  end
end
