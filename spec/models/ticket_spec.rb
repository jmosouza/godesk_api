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
#

require 'rails_helper'

RSpec.describe Ticket, type: :model do

  before :all do
    @customer = Customer.create username: 'ticketman', password: '123456'
  end

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
    t = Ticket.new author: @customer, title: 'i need help'
    expect(t.save).to be true
    expect(t.is_open?).to be true
    expect(t.is_closed?).to be false
  end

  it 'can be closed' do
    t = Ticket.new author: @customer, title: 'i need help'
    time_closed = t.close
    expect(t.save).to be true
    expect(t.is_open?).to be false
    expect(t.is_closed?).to be true
    expect(Time.at t.closed_at.to_i).to eq Time.at(time_closed.to_i)
  end

end
