class V1::TicketsController < V1::ApplicationController
  before_action :authenticate_user

  # List tickets accessible by the user.
  # Respond 304 Not Modified if unchanged.
  # See http://guides.rubyonrails.org/caching_with_rails.html#conditional-get-support
  def index
    service = V1::TicketsIndexService.new(current_user, params)
    @tickets = service.user_accessible_tickets
    render json: @tickets if stale? @tickets
  end

end
