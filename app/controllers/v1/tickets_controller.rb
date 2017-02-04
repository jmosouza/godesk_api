# == Description
#
# Manage tickets.
#
# The user can only manage tickets he has access to.
# Customer users can only see their own tickets.
# Admin and Attendant users can see all tickets.
class V1::TicketsController < V1::ApplicationController

  # GET
  # List tickets accessible by the user.
  def index
    service = V1::TicketsIndexService.new(current_user, params)
    tickets = service.user_accessible_tickets
    authorized_tickets = tickets.accessible_by(current_ability, :index)
    raise CanCan::AccessDenied.new if authorized_tickets.size != tickets.size
    render_for_api :index, json: tickets if stale? tickets
  end

  # GET
  # Show a ticket including its messages.
  def show
    ticket = show_ticket(params[:id])
    raise ActiveRecord::RecordNotFound if ticket.blank?
    authorize! :show, ticket
    render_for_api :show, json: ticket if stale? ticket
  end

  # POST
  # Create a new ticket.
  # TODO: Create with a message.
  def create
    ticket = current_user.tickets.build(ticket_params)
    authorize! :create, ticket
    if ticket.save
      head :created
    else
      render_errors ticket.errors.full_messages
    end
  end

  # GET
  # Export PDF report for tickets closed on last month.
  def report
    authorize! :report, Ticket

    # Date range for last month
    start_date = Time.zone.now.last_month.beginning_of_month
    final_date = Time.zone.now.beginning_of_month

    # Find all tickets closed on last month
    service = V1::TicketsIndexService.new(current_user, params)
    tickets = service.user_accessible_tickets.where('closed_at >= ? AND closed_at < ?', start_date, final_date)

    # e.g. January 2017
    formatted_month = start_date.strftime('%B %Y')

    # Start PDF
    pdf = Prawn::Document.new
    pdf.text "GODESK - CLOSED TICKETS"
    pdf.text formatted_month
    pdf.text "---"

    # Blank state
    if tickets.empty?
      pdf.text 'No tickets closed this month.'
    end

    # Content
    tickets.each do |t|
      pdf.text t.title
      pdf.text "Closed at: #{I18n.l t.closed_at, format: :long}"
      pdf.text "-"
    end

    # Send file
    file_name = "report-#{formatted_month.downcase.gsub ' ', '-'}.pdf"
    file_path = "#{Rails.root}/tmp/#{file_name}"
    pdf.render_file file_path
    send_file file_path, type: :pdf, filename: file_name
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

  # Extract params related to message.
  #
  # Do NOT require attributes here because
  # when they are missing this would raise
  #
  # +ActionController::ParameterMissing: param is missing or the value is empty+
  #
  # instead of returning proper validation
  # errors -- e.g. Title can't be blank.
  def ticket_params
    params[:ticket].permit(:title)
  end

end
