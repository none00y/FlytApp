Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      patch 'test'
    end
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new' 
    end
  end
  authenticated :user, ->(user){ user.basic_user? } do
    devise_scope :user do
      root to: 'users#index', as: :basic_user_root
    end
  end
  authenticated :user, ->(user){ user.admin? } do
    devise_scope :user do
      root to: 'users#index', as: :admin_root
    end
  end
end
