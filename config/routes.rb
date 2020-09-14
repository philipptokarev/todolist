Rails.application.routes.draw do
  root to: "projects#index"
  devise_for :users, path: :accounts
  resources :users do
    resources :projects do
      resources :tasks do
        member { post :toggle }
        collection { post :sort}
      end
    end
  end
end
