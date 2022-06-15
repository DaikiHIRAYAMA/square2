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

  root 'transactions#index'
end
