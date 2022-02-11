Rails.application.routes.draw do
  resources :talents
  resources :authors
  resources :courses

  jsonapi_resources :users
  jsonapi_resources :courses
end
