require 'api_constraint'

Rails.application.routes.draw do

  scope module: :v1, constraints: api_version(1, :default) do
    post 'signin' => 'user_token#create'
    post 'customer_signup' => 'user_token#customer_signup'
  end

end
