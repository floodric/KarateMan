Karate67272::Application.routes.draw do

  get "password_resets/new"

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
  resources :password_resets


  # final standing custom form
  match '/finalstandings/:id' => 'sections#final_standings', :as => :final_standings
  
  # fee paid quick link
  match '/feepaid/:id' => 'registrations#fee_paid', :as => :fee_paid

  # waiver signed quick link
  match '/waiversigned/:id' => 'students#waiver_signed', :as => :waiver_signed
  
  # Semi-static page routes
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'search' => 'home#search', :as => :search

  # Set the root url
  root :to => 'home#index'
  
end

