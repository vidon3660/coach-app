GymSport::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: { registrations: "registrations" }

  namespace :coach do
    root to: "panel#index"
  end
  
  resources :contacts
  resources :invitations #, except: [:create]
  resources :parameters
  resources :people do
    resources :invitations do # , only: [:create] do
      collection do
        post "training"
      end
    end
  end
  resources :players

  match "/banned" => "banned#index", as: :banned

  match "/complete" => "complete#edit", as: :complete
  put "/complete_user" => "complete#update", as: :complete_user

  match "/profile" => "profile#index", as: :profile
  match "/profile/informations" => "profile#informations", as: :profile_informations
  match "/profile/update" => "profile#update", as: :profile_update

  match "/search" => "search#index", as: :search
  match "/board" => "board#index", as: :board

  root to: "home#index"
  
end
