class Ability
  include CanCan::Ability

  # Define what each kind of user can do.
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  def initialize(user)

    if user.type == 'Admin'
      # Can create support agent accounts.
      can [ :create ], Attendant
      # Can do everything on any ticket.
      can [ :index, :show, :open, :close, :report ], Ticket
      # Can create messages on any open tickets.
      can [ :create ], Ticket::Message,
        author_id: user.id,
        ticket: { closed_at: nil }
    end

    if user.type == 'Attendant'
      # Can do everything on any ticket.
      can [ :index, :show, :open, :close, :report ], Ticket
      # Can create messages on any open tickets.
      can [ :create ], Ticket::Message,
        author_id: user.id,
        ticket: { closed_at: nil }
    end

    if user.type == 'Customer'
      # Can view and create their own tickets.
      can [ :index, :show, :create ], Ticket, author_id: user.id
      # Can create messages on their own open tickets.
      can [ :create ], Ticket::Message,
        author_id: user.id,
        ticket_id: user.tickets.pluck(:id),
        ticket: { closed_at: nil }
    end

  end
end
