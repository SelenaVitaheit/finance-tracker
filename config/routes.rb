Rails.application.routes.draw do
  get "categories/index"
  get "categories/show"
  get "categories/new"
  get "categories/edit"
  # Devise маршруты для аутентификации
  devise_for :users
  
  # Корневой маршрут
  root "dashboard#index"
  
  # Основные маршруты
  get "home/index"
  get "dashboard/index"
  
  # Ресурсные маршруты
  resources :transactions
  resources :goals
  resources :categories  # будет добавлено позже
end