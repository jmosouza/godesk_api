# == Description
#
# Base model for all types of users.
# It has a username and authenticates with a password.
#
# This class should not be instantiated directly.
# Instead, one of its subclasses should be used.
#
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  type            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_type      (type)
#  index_users_on_username  (username)
#

class User < ApplicationRecord

  ## :nodoc:
  # Secure the user with a password.
  has_secure_password

  ## :nodoc:
  # Validate the presence and uniqueness of the username.
  validates :username, presence: true, uniqueness: true

  ## :nodoc:
  # A user has many tickets and ticket messages.
  has_many :tickets
  has_many :ticket_messages

  ## :nodoc:
  # Customize the knock gem behaviour (jwt).
  # Return a valid user or +nil+ if not found.
  #
  # See https://github.com/nsarno/knock#customization
  def self.from_token_request(request)
    find_by_username request.params.dig(:auth, :username)
  end

end
