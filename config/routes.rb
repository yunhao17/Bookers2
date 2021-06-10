Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  
  resources :books, only:[:create, :index, :show, :destroy, :edit, :update]do
    resource :favorites, only: [:create, :destroy]
    
    resources :book_comments, only: [:create, :destroy]
  end
 
  resources :users, only: [:show, :index, :edit, :update]do
   resource :relationships, only: [:create, :destroy]
   get 'followings' => 'relationships#followings', as: 'followings'
   get 'followers' => 'relationships#followers', as: 'followers'
 end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
 
 get "search" => "searchs#search"
end
