# These examples are common for all User subclasses.
# See admin, attendant and customer in /specs.

RSpec.shared_examples 'user' do

  it 'requires a username' do
    u = described_class.new password: '123456'
    expect(u.save).to be false
    expect(u.errors[:username]).not_to be_empty
  end

  it 'requires a unique username' do
    u1 = described_class.new password: '123456', username: 'alfred'
    u2 = described_class.new password: '123456', username: 'alfred'
    expect(u1.save).to be true
    expect(u2.save).to be false # username already taken
    expect(u2.errors[:username]).not_to be_empty
  end

  it 'requires a password' do
    u = described_class.new username: 'beth'
    expect(u.save).to be false
    expect(u.errors[:password]).not_to be_empty
  end

  it 'does not persist the password' do
    described_class.create! username: 'claire', password: '123'
    expect(described_class.last.password).to be_nil
  end

  it 'authenticates' do
    username = 'daniel'
    password = '123456'
    described_class.create! username: username, password: password
    u = User.find_by_username username
    expect(u.authenticate password).not_to be false
  end

  it 'fails to authenticate with wrong credentials' do
    username = 'daniel'
    password = '123456'
    described_class.create! username: username, password: password
    u = User.find_by_username username
    expect(u.authenticate password.reverse).to be false
  end

  it 'has many tickets' do
    expect(described_class.instance_methods).to include :tickets
  end

  it 'has many messages in a ticket' do
    expect(described_class.instance_methods).to include :ticket_messages
  end

end
