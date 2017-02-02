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
# Indexes
#
#  index_tickets_on_author_id  (author_id)
#  index_tickets_on_closed_at  (closed_at)
#  index_tickets_on_title      (title)
#

class Ticket < ApplicationRecord
  include BelongsToAuthor

  ## :nodoc: a ticket belongs to an author that must be a customer.
  belongs_to :author, required: true, class_name: Customer
  has_many :messages

  validates :title, presence: true
  validates :author_is_waiting, inclusion: [ true, false ]

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

  # Close the ticket to indicate it is finished.
  # Set the +closed_at+ time and return it.
  def close
    self.closed_at = Time.zone.now
  end

  ## :nodoc: API

  acts_as_api

  api_accessible :index do |t|
    t.add :id
    t.add :title
    t.add :author_id
    t.add :author_username
    t.add :author_is_waiting
    t.add :closed_at
    t.add :created_at
    t.add :updated_at
  end

  api_accessible :show, extend: :index do |t|
    t.add :messages, template: :in_ticket
  end

end
