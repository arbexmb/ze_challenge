Rails.application.routes.draw do
  get 'partners' => 'partners#index'
  post 'partners' => 'partners#create'
  get 'partners/:id' => 'partners#show'
  get 'partners/search/:lng/:lat' => 'partners#search', :constraints => { :lng => /\-?\d+(.\d+)?/, :lat => /\-?\d+(.\d+)?/ }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
