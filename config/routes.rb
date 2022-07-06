Rails.application.routes.draw do
  get 'temp', to: 'temperature#index', as: :current_temp
  get 'edit_temp', to: 'temperature#edit', as: :edit_temp
  post 'update_temp', to: 'temperature#update', as: :update_temp
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root to: "home#index", as: :home
end
