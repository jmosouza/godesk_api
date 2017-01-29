Rails.application.routes.draw do
  post 'signin' => 'user_token#create'
  post 'customer_signup' => 'user_token#customer_signup'
end
