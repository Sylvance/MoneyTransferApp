# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/home'
  post 'pages/create'
  root 'pages#home'
end
