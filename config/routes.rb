Rails.application.routes.draw do
  resources :workout_data
  devise_for :users

  root to: "workout_data#index"
end
