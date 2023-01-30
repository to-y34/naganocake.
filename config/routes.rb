Rails.application.routes.draw do
  
  
  
  
  

  scope module: 'public' do
  resources :items, only: [:index, :show]
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  post '/orders/confirm' => 'orders#confirm'
  get 'orders/finish' => 'orders#finish'
  resources :orders, only: [:new, :index, :show, :create]
  resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
      delete 'destroy_all'
    end
  end
  
  end
  get 'customers/infomation/edit' => 'public/customers#edit'
  get 'customers/mypage' => 'public/customers#show'
  get 'customers/cancel' => 'public/customers#cancel'
  patch 'customers/close' => 'public/customers#close'
  patch 'customers/infomation' => 'public/customers#update'
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  
  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
