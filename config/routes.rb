Karate67272::Application.routes.draw do

  # Generated routes
  resources :events
  resources :registrations
  resources :sections
  resources :students
  resources :dojo_students #@TODO maybe break this up so we dont have index and show pages?
  resources :users         # SAME HERE
  resources :dojos
  resources :tournaments
  resources :users
  
  # login stuff
  resources :sessions
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login


  # final standing custom form
  match '/finalstandings/:id' => 'sections#final_standings', :as => :final_standings
  
  # fee paid custom form
  match '/feepaid/:id' => 'registrations#fee_paid', :as => :fee_paid
  
  # Semi-static page routes
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'search' => 'home#search', :as => :search

  # Set the root url
  root :to => 'home#index'
  
end

