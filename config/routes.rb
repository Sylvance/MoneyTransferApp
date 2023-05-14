Rails.application.routes.draw do
  get 'pages/home'
  post 'pages/create'
  root 'pages#home'
end
