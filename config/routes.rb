Rails.application.routes.draw do
  resources :workout_datas
  resources :upper_bodies
  resources :lower_bodies
  resources :arms
  resources :legs
  resources :cardios 
  resources :biceps
  resources :triceps
  resources :forearms
  
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: "home#index"
end
