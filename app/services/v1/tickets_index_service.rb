class V1::TicketsIndexService

  def initialize(user, params)
    @user = user
    @params = params
  end

  def user_accessible_tickets
    @user_accessible_tickets ||= user_type_tickets
  end

  private

  attr_reader :user, :params

  def user_type_tickets
    if user.type == 'Customer'
      all_tickets.where(author: user)
    else
      all_tickets
    end
  end

  def all_tickets
    Ticket.includes(:author)
          .search(params[:search])
          .sorted(params[:sort], params[:dir])
          .page(params[:page])
          .per(params[:limit])
  end

end

# TODO join latest message to tickets.
# .joins('JOIN ticket_messages m1 ON tickets.id = m1.ticket_id')
# .joins('LEFT JOIN ticket_messages m2 ON tickets.id = m2.ticket_id AND m1.created_at < m2.created_at')
# .where('m2.id IS NULL')
