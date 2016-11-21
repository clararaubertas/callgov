Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "/pages/:page" => "pages#show"
  resources :calling_scripts
  root 'calling_scripts#index'
end
