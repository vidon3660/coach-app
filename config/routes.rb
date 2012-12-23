GymSport::Application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  namespace :coach do
    root to: "panel#index"
  end
  
  namespace :admin do
    root to: "panel#index"
  end

  resources :contacts
  resources :invitations #, except: [:create]
  resources :people do
    resources :invitations, only: [:create]
  end

  match "/banned" => "banned#index", as: :banned

  match "/complete" => "complete#edit", as: :complete
  put "/complete_user" => "complete#update", as: :complete_user

  match "/profile" => "profile#index", as: :profile
  match "/profile/informations" => "profile#informations", as: :profile_informations
  match "/profile/update" => "profile#update", as: :profile_update

  match "/search" => "search#index", as: :search

  match "/welcome" => "welcome#index", as: :welcome

  root to: "home#index"
  
end
