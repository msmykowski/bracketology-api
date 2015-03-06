Rails.application.routes.draw do

  get '/teams', to: 'teams#index'

  get '/teams/:id', to: 'teams#show'

  get 'teams/rank/:stat', to: 'teams#rank'

  get 'players/rank/:stat', to: 'players#rank'

  get 'scores/update' => 'scores#update_games'

end
