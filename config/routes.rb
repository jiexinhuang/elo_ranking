Rails.application.routes.draw do
  root to: 'home#show'

  get '/:game_type' => 'players#index'
  get '/:game_type/games/new' => 'games#new'
  post '/:game_type/games' => 'games#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
