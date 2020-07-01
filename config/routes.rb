Rails.application.routes.draw do

  devise_scope :user do
    authenticated :user do
      root 'notes#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/index', to: 'notes#index'
  post 'notes/create', to: 'notes#create', as: :create_note
  delete 'notes/:id/delete', to: 'notes#delete', as: :delete_note
  get 'notes/:id/edit', to: 'notes#edit', as: :edit_note
  patch 'notes/:id', to: 'notes#update', as: :update_note
end
