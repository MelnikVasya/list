Todolist::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :task_lists
  root 'users#welcome'
  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  resources :tasks do
    member do
      post 'toggle'

      post 'priority_up'
      get  'priority_up'

      post 'priority_down'
      get  'priority_down'
    end
  end
end
