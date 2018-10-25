Rails.application.routes.draw do
  resources :questions
  root "home#index"
  get "/team" => "home#team"
  get "team/rick" => "home#rick"
  get "team/craig" => "home#craig"
  get "team/drew" => "home#drew"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
