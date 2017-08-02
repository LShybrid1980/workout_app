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
  resources :shoulders
  resources :chests
  resources :upper_backs
  resources :abdominals
  resources :lower_backs
  resources :hamstrings
  resources :calves
  resources :quads
  resources :treadmills
  resources :ellipticals
  
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: "home#index"
end
