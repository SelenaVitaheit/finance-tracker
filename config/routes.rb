Rails.application.routes.draw do
  # Devise маршруты для аутентификации
  devise_for :users
  
  # Корневой маршрут
  root "home#index"
  get "home/index"
  
  # Ресурсные маршруты для транзакций (CRUD)
  resources :transactions
  
  # В будущем добавим:
  # resources :categories  
  # resources :goals
end