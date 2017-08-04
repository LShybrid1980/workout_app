Rails.application.routes.draw do
  resources :workout_datas do 
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
  end  

  devise_for :users, controllers: { registrations: 'registrations' }

  root to: "home#index"
end

    
  
