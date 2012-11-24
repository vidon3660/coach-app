GymSport::Application.routes.draw do

  devise_for :users

  namespace :coach do
    root to: "panel#index"
  end
  
  namespace :admin do
    root to: "panel#index"
  end

  match "/complete" => "complete#edit", as: :complete
  match "/welcome" => "welcome#index", as: :welcome
  root to: "home#index"
  
end
