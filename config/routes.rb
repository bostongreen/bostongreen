require 'api_subdomain'


Bostonhack::Application.routes.draw do

  get "events/index"

  get "events/show"

  get "comment/show"

  get "search/index"

  get "features/index"

  get "features/show"
  
  
  namespace :v1 do 
    constraints (ApiSubdomain) do
      resources :neighborhoods, :only => [:show,:index]
      resources :open_spaces, :only => [:show,:index]
      resources :features, :only => [:show]
    end
  end

  resources :map
  
  resources :near_me
  
  resources :events

  match "/near", :to =>"near_me#index"  
  
  match "/search", :to =>"search#index"
  
  match "/comment/:id", :to => "comment#show"
  
  resources :open_spaces do |open_space|
    resources :nearby_events
  end
  
  resources :neighborhoods
  resources :features

  get "home/index"
  match "/about", :to => "about#index"
  
  match "/getinvolved", :to => "getinvolved#index"

  root :to => "home#index"

end
