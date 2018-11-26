Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    #get 'sessions/new'
    get 'login' => :new
    #get 'sessions/create'
    post 'login' => :create
    #get 'sessions/destroy'
    delete 'logout' => :destroy
  end

  
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end

  #get 'store/index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
