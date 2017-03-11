READ_ACTIONS  = %i(:index :show)
WRITE_ACTIONS = %i(:new :edit :update :delete)

Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
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
    resources :games do
      member do
        get :join
      end
    end
    root "dashboard#index"
  end

  constraints Clearance::Constraints::SignedOut.new do
    resources :games, only: READ_ACTIONS do
      member do
        get :join
      end
      resources :categories
      resources :characters
      resources :districts
      resources :factions
      resources :players
    end
    root 'dashboard#landing', as: :signed_out_root
  end
end
