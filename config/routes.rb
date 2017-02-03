Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "/pages/:page" => "pages#show"
  resources :scripts, :controller => :calling_scripts do
    member do
      post 'archive'
    end
  end
  root 'calling_scripts#index'
end
