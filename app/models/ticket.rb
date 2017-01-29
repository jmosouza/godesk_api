# == Description
#
# Model for a support ticket.
# It has an author, a title and the time it was closed.
#
# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  closed_at  :datetime
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Ticket < ApplicationRecord

  ## :nodoc:
  # A ticket belongs to an author.
  # The author must be a customer.
  belongs_to :author, class_name: Customer

  ## :nodoc:
  # Validate the presence of a title.
  validates :title, presence: true

  ##
  # Return +true+ when the +closed_at+ time is +null+.
  def is_open?
    closed_at.blank?
  end

  ##
  # Return +true+ when a call to +is_open?+ would return +false+.
  def is_closed?
    !is_open?
  end

  ##
  # Close the ticket to indicate it is finished.
  # Set the +closed_at+ time and return it.
  def close
    self.closed_at = Time.zone.now
  end

end
