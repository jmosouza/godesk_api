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

require 'rails_helper'

RSpec.describe Ticket::Message, type: :model do

  fixtures :users, :tickets

  it 'requires an author' do
    t = described_class.new
    expect(t.save).to be false
    expect(t.errors[:author]).not_to be_empty
  end

  it 'requires a ticket' do
    t = described_class.new
    expect(t.save).to be false
    expect(t.errors[:ticket]).not_to be_empty
  end

  it 'requires a body' do
    t = described_class.new
    expect(t.save).to be false
    expect(t.errors[:body]).not_to be_empty
  end

  it 'can have an author that is a Customer' do
    author = users(:customer_0)
    ticket = tickets(:ticket_0)
    t = described_class.new ticket: ticket, author: author, body: 'thanks'
    expect(t.save).to be true
  end

  it 'can have an author that is an Attendant' do
    author = users(:attendant_0)
    ticket = tickets(:ticket_0)
    t = described_class.new ticket: ticket, author: author, body: 'thanks'
    expect(t.save).to be true
  end

  it 'can have an author that is an Admin' do
    author = users(:admin_0)
    ticket = tickets(:ticket_0)
    t = described_class.new ticket: ticket, author: author, body: 'thanks'
    expect(t.save).to be true
  end

end
