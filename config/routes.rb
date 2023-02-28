Rails.application.routes.draw do
  get 'clients/index'
  get 'clients/show'
  get 'clients/new'
  get 'clients/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :imports, only: [:new, :create] do 
    collection do
      get :import
    end
  end
end
