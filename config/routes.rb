Rails.application.routes.draw do
  # Devise маршруты для аутентификации
  devise_for :users
  
  # Корневой маршрут
  root "home#index"
  get "home/index"
  
  # Будем добавлять здесь маршруты для транзакций, категорий, целей
  # resources :transactions
  # resources :categories  
  # resources :goals
end