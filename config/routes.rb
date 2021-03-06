IcfOnRails::Application.routes.draw do

  root 'welcome#index'
  resources :attachments

  resources :campaign_orders

  resources :employees

  resources :line_items

  #root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
