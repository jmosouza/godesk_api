# == Description
#
# Manage ticket messages.
#
# The user can only manage messages he has access to.
# Customer users can only see their own tickets' messages.
# Admin and Attendant users can see all tickets' messages.
class V1::TicketMessagesController < V1::ApplicationController

  # POST /tickets/:id/messages
  #
  # Create a new message authored by the current user.
  # Toggle the +author_is_waiting+ ticket attribute based on user type.
  def create
    message = current_user.ticket_messages.build(message_params)
    authorize! :create, message
    if message.save
      toggle_author_is_waiting(message)
      head :created
    else
      render_errors message.errors.full_messages
    end
  end

  private

  # Extract params related to message.
  #
  # Do NOT require attributes here because
  # when they are missing this would raise
  #
  # +ActionController::ParameterMissing: param is missing or the value is empty+
  #
  # instead of returning proper validation
  # errors -- e.g. Title can't be blank.
  def message_params
    params[:message].permit(:ticket_id, :body)
  end

  # Set +author_is_waiting+ attribute to true if the
  # message was posted by a Customer, false otherwise.
  #
  # TODO: Track exception
  def toggle_author_is_waiting(message)
    ticket = message.ticket
    message_is_by_customer = message.author.type == 'Customer'
    ticket.update! author_is_waiting: message_is_by_customer
  rescue => e
    logger.warn "Failed to toggle 'author_is_waiting' for ticket: #{ticket.inspect}"
    logger.warn e
  end

end
