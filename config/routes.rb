Rails.application.routes.draw do

  get "login" => "user#login_form"
  post "login" => "user#login"
  get "logout" => "user#logout"
  get "signup" => "user#new"
  post "user/create" => "user#create"
  get "user/index" => "user#index"
  get "user/:id/edit" => "user#edit"
  post "user/:id/update" => "user#update"
  get "user/:id/likes" => "user#likes"
  get "user/:id" => "user#show"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/destroy" => "posts#destroy"
  post "posts/create" => "posts#create"
  get "posts/new" => "posts#new"
  get "/" => "home#top"
  get "about" => "home#about"

  get "likes/:post_id/create" => "likes#create"
  get "likes/:post_id/destroy" => "likes#destroy"

end
