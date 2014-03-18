TOERHWebAPI::Application.routes.draw do
  root 'home#index'
  
  get "/auth/:provider/callback" => "session#create"
  get "/signout" => "session#destroy", :as => :signout
  get "/authenticate" => "session#authenticate"
  
  get "home/new"
  post "home/create"
  
  get "login/login"
  post "login/login_attempt"
  
  get "admin/index"
  get "admin/logout"
  patch "admin/update"
  
  resources :admin
  
  namespace :api do
    namespace :v1 do
      resources :resource, :defaults => { :format => "json" }
      resources :tag, :defaults => { :format => "json" }
      resources :licence, :defaults => { :format => "json" }
      resources :resourcetype, :defaults => { :format => "json" }
      resources :user, :defaults => { :format => "json" }
    end
  end
  
  match "*path" => redirect("/"), :via => :get # Handle 404
end
