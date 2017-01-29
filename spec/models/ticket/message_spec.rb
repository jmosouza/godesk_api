require 'rails_helper'

RSpec.describe Ticket::Message, type: :model do

  before :all do
    @customer = Customer.create username: 'ticketer', password: '123456'
    @attendant = Attendant.create username: 'ticketer', password: '123456'
    @admin = Admin.create username: 'ticketer', password: '123456'
    @ticket = Ticket.create author: @customer, title: 'some ticket'
  end

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
    t = described_class.new ticket: @ticket, author: @customer, body: 'thanks'
    expect(t.save).to be true
  end

  it 'can have an author that is an Attendant' do
    t = described_class.new ticket: @ticket, author: @attendant, body: 'thanks'
    expect(t.save).to be true
  end

  it 'can have an author that is an Admin' do
    t = described_class.new ticket: @ticket, author: @admin, body: 'thanks'
    expect(t.save).to be true
  end

end
