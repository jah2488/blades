Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
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
    root "games#index"
  end

  constraints Clearance::Constraints::SignedOut.new do
    root 'factions#index', as: :signed_out_root
  end
end
