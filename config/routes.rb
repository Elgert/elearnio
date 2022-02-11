Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :courses, only: [:index, :show, :create, :update, :destroy]
  resources :enrollments, only: [:index, :show, :create, :update, :destroy]

  jsonapi_resources :users
  jsonapi_resources :courses
end
