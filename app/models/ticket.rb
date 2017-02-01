# == Description
#
# Model for a support ticket.
# It has an author, a title and the time it was closed.
#
# == Schema Information
#
# Table name: tickets
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  closed_at         :datetime
#  author_id         :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  author_is_waiting :boolean          default("1"), not null
#

class Ticket < ApplicationRecord

  ## :nodoc:
  # A ticket belongs to an author.
  # The author must be a customer.
  belongs_to :author, class_name: Customer

  ## :nodoc:
  # Validate the presence of a title.
  validates :title, presence: true

  # Sort results by a column and direction.
  scope :sorted, -> (column = :updated_at, direction = :desc) do
    order(column, direction)
  end

  # Search by title or author username.
  scope :search, -> (query = nil) do
    return if query.blank?
    joins(:author).
    where('title LIKE :q OR users.username LIKE :q', q: "%#{query}%")
  end

  # Return +true+ when the +closed_at+ time is +null+.
  def is_open?
    closed_at.blank?
  end

  # Return +true+ when a call to +is_open?+ would return +false+.
  def is_closed?
    !is_open?
  end

  # Close the ticket to indicate it is finished.
  # Set the +closed_at+ time and return it.
  def close
    self.closed_at = Time.zone.now
  end

  # == Presentation

  # Return the username of the author by calling +author.username+.
  def author_username
    author.username
  end

end
