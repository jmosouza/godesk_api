# Filter tickets by user type.
# Customer users can only see their own tickets.
# Admin and Attendant users can see all tickets.
# Parameters: search, sort, dir, page, limit
class V1::TicketsIndexService

  def initialize(user, params)
    @user = user
    @params = params
  end

  def user_accessible_tickets
    @user_accessible_tickets ||= user_type_tickets # cache result
  end

  private

  attr_reader :user, :params

  def user_type_tickets
    if user.type.in? %w( Admin Attendant )
      all_tickets
    elsif user.type == 'Customer'
      all_tickets.where(author: user)
    else
      # This condition should never be met under regular conditions.
      # In case it does, raise a clear error.
      # Response will be 500.
      raise "Invalid user type: #{user.type}"
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
