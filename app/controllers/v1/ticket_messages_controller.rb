# == Description
#
# Manage ticket messages.
#
# The user can only manage messages he has access to.
# Customer users can only see their own tickets' messages.
# Admin and Attendant users can see all tickets' messages.
#
# TODO: Authorize all requests.
class V1::TicketMessagesController < V1::ApplicationController
  before_action :authenticate_user

  # POST /tickets/:id/messages
  #
  # Create a new message authored by the current user.
  #
  # TODO: Authorize message
  def create
    message = current_user.ticket_messages.build(message_params)
    if message.save
      head :created
    else
      render_errors message.errors.full_messages
    end
  end

  private

  # Extract params related to message.
  #
  # Do NOT require +message+ here because when it is missing this would raise
  # +ActionController::ParameterMissing: param is missing or the value is empty: message+
  # instead of returning readable validation errors -- e.g. Body can't be blank.
  def message_params
    params[:message].permit(:ticket_id, :body)
  end

end
