Kweenan::Application.routes.draw do
  devise_for :users do
    get "new_merchant", :to => "devise/registrations#new"
    get "new_customer", :to => "devise/registrations#new"
  end
  
  resource :user_profile, :except => :show
  resources :pages

  root :to => 'pages#show', :id => 'front'
end