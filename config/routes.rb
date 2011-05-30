Kweenan::Application.routes.draw do
  devise_for :users do
    get "new_merchant", :to => "devise/registrations#new"
    get "new_customer", :to => "devise/registrations#new"
  end

  root :to => 'pages#show', :id => 'front'
end