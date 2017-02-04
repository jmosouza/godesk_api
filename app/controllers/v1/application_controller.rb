# == Description
#
# Base class for all controllers in V1
class V1::ApplicationController < ActionController::API
  before_action :authenticate_user

  ## :nodoc:
  # Provide authentication mechanism
  # See https://github.com/nsarno/knock#usage
  include Knock::Authenticable

  ## :nodoc:
  # In Rails 5 API mode it's necessary to include ActsAsApi::Rendering.
  # See https://github.com/fabrik42/acts_as_api/issues/104#issuecomment-276059000
  include ActsAsApi::Rendering

  ## :nodoc:
  # In Rails 5 API mode it's necessary to include CanCan::ControllerAdditions.
  # See https://github.com/CanCanCommunity/cancancan#getting-started
  include CanCan::ControllerAdditions

  # :nodoc:
  # Respond 403 when CanCan denies access to a resource.
  rescue_from CanCan::AccessDenied do |exception|
    head :forbidden
  end

  # Render an array of human readable strings as json in a root node +errors+.
  def render_errors(errors)
    raise unless errors.is_a? Array
    strings = errors.select { |e| e.is_a? String }
    raise if strings.empty?
    render json: { errors: strings }, status: :unprocessable_entity
  end

end
