Easyblog::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
  end
end
