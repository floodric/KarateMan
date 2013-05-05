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
  

  resources :sessions
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match '/finalstandings/:id' => 'sections#final_standings', :as => :final_standings
  match '/savefinalstandings/:id' => 'sections#save_final_standings', :as => :edit_final_standings
  
  # Semi-static page routes
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'search' => 'home#search', :as => :search

  # Set the root url
  root :to => 'home#index'
  
end

