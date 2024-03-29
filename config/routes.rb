Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  resources :users do
  end

  resources :airfields do
  end

  resources :connections do
  end

  resources :airplanes do
  end

  resources :passengers do
  end

  unauthenticated :user do
    devise_scope :user do
      root to: 'users/registrations#new'
    end
  end
  authenticated :user, ->(user) { user.basic_user? } do
    devise_scope :user do
      root to: 'airfields#index', as: :basic_user_root
    end
  end
  authenticated :user, ->(user) { user.admin? } do
    devise_scope :user do
      root to: 'users#index', as: :admin_root
    end
  end
end
