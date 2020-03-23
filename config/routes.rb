Rails.application.routes.draw do
  resources :questionnaires, only: [:index, :create]
  resource :heatmap, only: [:show]
  resources :web_push_subscribers, only: [:create]

  root to: "pages#index"

  if Rails.env.development?
    require "sidekiq/web"
    mount Sidekiq::Web => '/sidekiq'
  end
end
