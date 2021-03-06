Kweenan::Application.routes.draw do
  devise_for :users do
    get "new_merchant", :to => "devise/registrations#new"
    get "new_customer", :to => "devise/registrations#new"
  end
  
  resources :merchants, :except => [:new, :create, :edit, :update]
  resources :pages
  resources :brands, :only => :index
  
  resource :merchant_profile, :controller => 'merchants'
  
  resources :photos, :only => [:create, :destroy]
  resources :merchant_photos, :only => [:create, :destroy]
  resources :profile_photos, :only => [:create, :destroy]
  
  resource :user_profile, :except => :show

  match '/exception', :to => 'application#exception'
  root :to => 'pages#show', :id => 'front'
end