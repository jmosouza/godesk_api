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

require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
