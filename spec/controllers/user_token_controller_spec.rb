require 'rails_helper'
require 'jwt'

RSpec.describe UserTokenController do

  it 'registers a customer' do
    user_params = { username: 'ana user_token_controler', password: '123456' }
    post :customer_signup, params: { auth: user_params }
    token = JSON(response.body)['jwt']
    expect(response.status).to eq 201
    expect(token).not_to be_blank
  end

  it 'registers a customer ignoring malicious type parameter' do
    user_params = { username: 'ana user_token_controler', password: '123456', type: 'Admin' }
    post :customer_signup, params: { auth: user_params }
    token = JSON(response.body)['jwt']
    decoded_token = JWT.decode token, nil, false
    user_id = decoded_token[0]['sub']
    type = User.find(user_id).type

    expect(response.status).to eq 201
    expect(token).not_to be_blank
    expect(type).to eq 'Customer'
  end

  it 'authenticates a customer' do
    user_params = { username: 'john user_token_controler', password: '123456' }
    Customer.create user_params
    post :create, params: { auth: user_params }
    token = JSON(response.body)['jwt']
    expect(response.status).to eq 201
    expect(token).not_to be_blank
  end

  it 'fails to authenticate a non-existing customer' do
    user_params = { username: 'who user_token_controler', password: '123456' }
    post :create, params: { auth: user_params }
    expect(response.status).to eq 404
    expect(response.body).to be_blank
  end

end
