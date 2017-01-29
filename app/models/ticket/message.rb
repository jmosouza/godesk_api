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
#  author_id  :integer
#  ticket_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ticket::Message < ApplicationRecord

  ## :nodoc:
  # Ticket::Message belongs to a Ticket and to an Author.
  # The author can be any type of User.
  belongs_to :ticket
  belongs_to :author, class_name: User

  ## :nodoc:
  # The text body is mandatory.
  validates :body, presence: true

end
