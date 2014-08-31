Todolist::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :task_lists do
    collection { post :sort }
  end
  root 'users#welcome'
  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  resources :deadlines
  resources :tasks do

    member do
      post 'toggle'
    end
  end
end
