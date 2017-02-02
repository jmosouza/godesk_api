require 'api_constraint' # see lib/api_constraint.rb

Rails.application.routes.draw do

  scope module: :v1, constraints: api_version(1, :default) do

    # Authentication
    post 'signin' => 'user_token#create'
    post 'customer_signup' => 'user_token#customer_signup'

    # Resources
    resources :tickets,  only: [ :index, :show, :create ] do
      get :report, on: :collection
    end
    resources :ticket_messages, only: [ :create ]

  end

end
