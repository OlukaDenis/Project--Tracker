# frozen_string_literal: true

Rails.application.routes.draw do
  resources :groups
  resources :projects
  root 'sessions#new'

  post 'signup', to: 'users#create'
  get 'signup', to: 'users#new'

  post 'signin', to: 'sessions#create'
  get 'signin', to: 'sessions#new'

  delete 'logout', to: 'sessions#destroy'

  get 'external', to: 'projects#external'

  resources :users, only: %w[new create show index]
end
