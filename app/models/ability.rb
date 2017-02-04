class Ability
  include CanCan::Ability

  # Define what each kind of user can do.
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  def initialize(user)

    if user.type == 'Admin'
      can [ :create ], Attendant
      can [ :index, :show, :report ], Ticket
      can [ :create ], Ticket::Message,
        author_id: user.id,
        ticket: { closed_at: nil }
    end

    if user.type == 'Attendant'
      can [ :index, :show, :report ], Ticket
      can [ :create ], Ticket::Message,
        author_id: user.id,
        ticket: { closed_at: nil }
    end

    if user.type == 'Customer'
      can [ :index, :show, :create ], Ticket, author_id: user.id
      can [ :create ], Ticket::Message,
        author_id: user.id,
        ticket_id: user.tickets.pluck(:id),
        ticket: { closed_at: nil }
    end

  end
end
