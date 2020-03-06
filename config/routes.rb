Rails.application.routes.draw do
  resources :questionnaires
  resources :browser_locations
  root to: "pages#index"
end
