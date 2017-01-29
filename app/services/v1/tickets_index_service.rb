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
    Ticket.joins(:author)
          .preload(:author)
          .search(params[:search])
          .sorted(params[:sort], params[:dir])
          .page(params[:page])
          .per(params[:limit])
  end

end
