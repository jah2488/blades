Rails.application.routes.draw do
  resources :district_factions
  resources :district_characters
  resources :faction_characters
  resources :player_traumas
  resources :players
  resources :characters
  resources :factions
  resources :categories
  resources :districts
  resources :games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
