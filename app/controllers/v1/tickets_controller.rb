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
  before_action :authenticate_user

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

  private

  # Find a ticket by +id+ including messages ordered by +created_at+ attribute.
  def show_ticket(id)
    Ticket
      .where(id: id)
      .includes(messages: :author)
      .order('ticket_messages.created_at DESC')
      .first
  end

end
