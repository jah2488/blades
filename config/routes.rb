READ_ACTIONS  = %i(:index :show)
WRITE_ACTIONS = %i(:new :edit :update :delete)

Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    resources :user_players
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
    root "dashboard#index"
  end

  constraints Clearance::Constraints::SignedOut.new do
    resources :games, only: READ_ACTIONS do
      resources :categories
      resources :characters
      resources :districts
      resources :factions
      resources :players
    end
    root 'factions#index', as: :signed_out_root
  end
end
