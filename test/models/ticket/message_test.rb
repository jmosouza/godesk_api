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

require 'test_helper'

class Ticket::MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
