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

require 'rails_helper'

RSpec.describe Ticket, type: :model do

  fixtures :users

  it 'requires an author' do
    t = Ticket.new
    expect(t.save).to be false
    expect(t.errors[:author]).not_to be_empty
  end

  it 'requires a title' do
    t = Ticket.new
    expect(t.save).to be false
    expect(t.errors[:title]).not_to be_empty
  end

  it 'is open when created' do
    author = users(:customer_0)
    t = Ticket.new author: author, title: 'i need help'
    expect(t.save).to be true
    expect(t.closed_at).to be nil
  end

  it 'can be closed' do
    author = users(:customer_0)
    t = Ticket.new author: author, title: 'i need help'
    time_closed = t.close
    expect(t.save).to be true
    expect(Time.at t.closed_at.to_i).to eq Time.at(time_closed.to_i)
  end

end
