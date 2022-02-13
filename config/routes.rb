Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get :user_enrollments
      get :authored_courses
    end
  end
  resources :courses, only: [:index, :show, :create, :update, :destroy]
  resources :enrollments, only: [:index, :create, :destroy]

  jsonapi_resources :users
  jsonapi_resources :courses
end
