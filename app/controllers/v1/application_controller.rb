# == Description
#
# Base class for all controllers in V1
class V1::ApplicationController < ActionController::API

  ## :nodoc:
  # Provide authentication mechanism
  # See https://github.com/nsarno/knock#usage
  include Knock::Authenticable

  ## :nodoc:
  # In Rails 5 API mode it's necessary to include ActsAsApi::Rendering.
  # See https://github.com/fabrik42/acts_as_api/issues/104#issuecomment-276059000
  include ActsAsApi::Rendering

end
