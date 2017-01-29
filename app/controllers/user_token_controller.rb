# == Description
#
# Authenticate the user using JWT with the knock gem.
#
# See https://github.com/nsarno/knock#getting-started

class UserTokenController < Knock::AuthTokenController

  ## :nodoc:
  # Skip authenticating for the +customer_signup+ action because the user doesn't exist yet.
  skip_before_action :authenticate, only: :customer_signup

  # Register a new customer and respond with a token or any errors.
  def customer_signup
    customer = Customer.new(customer_params)
    if customer.save
      # The following methods belong to Knock::AuthTokenController
      # See https://github.com/nsarno/knock/blob/master/app/controllers/knock/auth_token_controller.rb
      authenticate
      create
    else
      render json: customer.errors, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:auth).permit(:username, :password)
  end

end
