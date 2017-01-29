class V1::TicketsController < V1::ApplicationController
  before_action :authenticate_user

  def index
    service = V1::TicketsIndexService.new(current_user, params)
    @tickets = service.user_accessible_tickets
    return if stale? @tickets
  end

end
