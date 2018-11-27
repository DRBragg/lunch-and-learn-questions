Rails.application.routes.draw do
  resources :ash_contacts
  resources :questions
  root "home#index"
  get "/team" => "home#team"
  get "/team/rick" => "home#rick"
  get "/team/craig" => "home#craig"
  get "/team/drew" => "home#drew"
  post "/slack/questions" => "slack/questions#create"
  post "/slack/experiments/hockey/stick-and-pucks" => "experiments/hockey/hockey#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
