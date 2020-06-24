Rails.application.routes.draw do

  devise_scope :user do
    authenticated :user do
      root 'notes#dashboard', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/dashboard', to: 'notes#dashboard'
  post 'notes/create'
  delete 'notes/delete'
  get 'notes/edit'
  put 'notes/update'
end
