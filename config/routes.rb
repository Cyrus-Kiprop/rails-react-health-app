Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :todos, only: :index
  end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do

    get 'admin/measures', to: 'admin#index'

    resources :measures do
      resources :measurements
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  root 'welcome#index'
end
