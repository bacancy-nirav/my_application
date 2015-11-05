Rails.application.routes.draw do

  root 'home_pages#home'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

	get '/home/user' => 'home_pages#users', as: :user
	get '/home/help' => 'home_pages#help', as: :help
	get '/home/about' => 'home_pages#about', as: :about
	get '/home/contact' => 'home_pages#contact', as: :contact
	get '/home/news' => 'home_pages#news', as: :news
	get '/home/users'=> 'home_pages#show',as: :all_users
	get '/home/send_friend_request' => 'home_pages#send_friend_request',as: :send_friend_request 
	get '/home/approve_friend_request' => 'home_pages#approve_friend_request', as: :approve_friend_request
	get '/home/my_friends_list' => 'home_pages#my_friends', as: :my_friends

	delete '/post/remove_image/:id' => 'posts#remove_image', as: :remove_image
	get '/post/see_more' => 'posts#see_more', as: :see_more
	# resources :posts
	# resources :comments

	resources :posts do
  	resources :comments
	end
end