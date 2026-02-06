Rails.application.routes.draw do
  # Devise маршруты для аутентификации
  devise_for :users
  
  # Корневой маршрут - теперь Dashboard
  root "dashboard#index"
  
  # Основные маршруты
  get "home/index"
  get "dashboard/index"
  
  # Ресурсные маршруты
  resources :transactions
  # resources :categories  # будет добавлено позже
  # resources :goals       # будет добавлено позже
end