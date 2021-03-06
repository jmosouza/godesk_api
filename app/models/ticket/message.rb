# == Description
#
# Model for the messages inside a Ticket.
#
# == Schema Information
#
# Table name: ticket_messages
#
#  id         :integer          not null, primary key
#  body       :string(255)
#  author_id  :integer          not null
#  ticket_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ticket_messages_on_author_id  (author_id)
#  index_ticket_messages_on_ticket_id  (ticket_id)
#

class Ticket::Message < ApplicationRecord
  include BelongsToAuthor

  ## :nodoc:
  # Ticket::Message belongs to a Ticket and to an Author.
  # The author can be any type of User.
  belongs_to :ticket, required: true
  belongs_to :author, required: true, class_name: User

  ## :nodoc:
  # The text body is mandatory.
  validates :body, presence: true

  ## :nodoc: API

  acts_as_api

  api_accessible :in_ticket do |t|
    t.add :id
    t.add :body
    t.add :author_id
    t.add :author_username
    t.add :created_at
    t.add :updated_at
  end

end
