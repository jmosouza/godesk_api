# == Description
#
# Base class for all controllers in V1
class V1::ApplicationController < ActionController::API
  include Knock::Authenticable
end
