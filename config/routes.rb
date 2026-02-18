Rails.application.routes.draw do
  resources :categories
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