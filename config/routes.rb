CoachApp::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: { registrations: "registrations" }

  resources :contacts
  resources :events
  resources :friendships #, only: [:delete]
  resources :invitations, except: [:show, :edit]
  resources :messages, only: [:index, :sent, :show, :destroy] do
    collection do
      get 'sent'
    end
  end
  resources :parameters
  resources :people do
    resources :messages, only: [:new, :create]
    resources :invitations do # , only: [:create] do
      collection do
        post "training"
      end
    end
  end
  resources :places
  resources :players
  resources :trainings, only: [:show, :destroy]
  resources :user_prohibitions


  match "/banned" => "banned#index", as: :banned

  match "/complete" => "complete#edit", as: :complete
  put "/complete_user" => "complete#update", as: :complete_user

  match "/profile" => "profile#index", as: :profile
  match "/profile/informations" => "profile#informations", as: :profile_informations
  match "/profile/update" => "profile#update", as: :profile_update
  match "/profile/about" => "profile#about", as: :profile_about

  match "/search" => "search#index", as: :search
  match "/find" => "search#find", as: :find
  match "/board" => "board#index", as: :board

  root to: "home#index"
  
end
