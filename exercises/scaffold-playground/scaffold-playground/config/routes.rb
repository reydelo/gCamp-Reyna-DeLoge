Rails.application.routes.draw do
  resources :people

  resources :rails

  root "home#dashboard"
end
