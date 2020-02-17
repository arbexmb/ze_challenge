Rails.application.routes.draw do
  get 'partners' => 'partners#index'
  post 'partners' => 'partners#create'
  get 'partners/:id' => 'partners#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
