Rails.application.routes.draw do

  get '/teams', to: 'teams#index'

  get '/teams/:id', to: 'teams#show'

  get 'teams/rank/:stat', to: 'teams#rank'

  get 'players/rank/:stat', to: 'players#rank'

  get 'scores/update' => 'scores#update_games'

  get 'bracket' => 'bracket#index'
  get 'bracket/info' => 'bracket#info'
  get 'bracket/fill' => 'bracket#populate_bracket_games'
  get 'bracket/games' => 'bracket#games'

end
