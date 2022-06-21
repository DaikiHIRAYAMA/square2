Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :transactions do
    resources :records
    get 'all_index', :on => :collection
    get 'rents_index', :on => :collection
    get 'borrows_index', :on => :collection
 
  end

  resources :transactions do
    resources :records do
      get 'push_mail', :on => :member
      get 'note',:on => :member
    end
  end

 # devise_for :users, path_names: { registration: 'show' }
 devise_scope :user do
  get 'mypage', to: 'devise/registrations#show', as: :mypage
 # delete 'logput', to: 'devise/registrations#destroy', as: :destroy


 # post 'signup', to: 'devise/registrations#create', as: :customer_registration
end

  root 'transactions#index'
  
  get '*path', controller: 'application', action: 'render_404'
end
