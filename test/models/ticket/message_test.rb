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

require 'test_helper'

class Ticket::MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
