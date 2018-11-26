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


  resources :users
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'


  root 'store#index', as: 'store'
  
  resources :products do
    get :who_bought, on: :member
  end
  
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
