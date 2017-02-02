# == Description
#
# Manage tickets.
#
# The user can only manage tickets he has access to.
# Customer users can only see their own tickets.
# Admin and Attendant users can see all tickets.
#
# TODO: Authorize all requests.
class V1::TicketsController < V1::ApplicationController

  # List tickets accessible by the user.
  #
  # TODO: Authorize tickets.
  def index
    service = V1::TicketsIndexService.new(current_user, params)
    tickets = service.user_accessible_tickets
    render_for_api :index, json: tickets if stale? tickets
  end

  # Show a ticket including its messages.
  #
  # TODO: Authorize ticket.
  def show
    ticket = show_ticket(params[:id])
    raise ActiveRecord::RecordNotFound if ticket.blank?
    render_for_api :show, json: ticket if stale? ticket
  end

  def create
    ticket = current_user.tickets.build(ticket_params)
    if ticket.save
      head :created
    else
      render_errors ticket.errors.full_messages
    end
  end

  private

  # Find a ticket by +id+ including messages ordered by +created_at+ attribute.
  def show_ticket(id)
    Ticket
      .where(id: id)
      .includes(messages: :author)
      .order('ticket_messages.created_at DESC')
      .first
  end

  # Extract params related to ticket.
  #
  # Do NOT require attributes here because when they are missing this would raise
  # +ActionController::ParameterMissing: param is missing or the value is empty+
  # instead of returning readable validation errors -- e.g. Title can't be blank.
  def ticket_params
    params[:ticket].permit(:title)
  end

end
