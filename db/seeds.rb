# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# ATTENTION!!!
#
# This file is being used to seed SAMPLE DATA only. Use it for developemnt.
# If you absolutely need to use it in other stages, set CAN_SEED_DATABASE to any value.

exit unless Rails.env.development? || ENV['CAN_SEED_DATABASE'].present?

puts 'Seeding database. This may take a few seconds...'

# Using activerecord-import gem.
# See https://github.com/zdennis/activerecord-import/wiki/Examples

# Sample admins
admins = []
1.times do |n|
  admins << Admin.new(username: "admin_#{n}", password: '123456')
end
Admin.import admins

# Sample attendants
attendants = []
5.times do |n|
  attendants << Attendant.new(username: "attendant_#{n}", password: '123456')
end
Attendant.import attendants

# Sample customers
customers = []
50.times do |n|
  customers << Customer.new(username: "customer_#{n}", password: '123456')
end
Customer.import customers

# Sample tickets
d = 0 # how many days ago the ticket was closed
tickets = []
Customer.all.each do |c|
  2.times do |n|
    tickets << Ticket.new do |t|
      t.title = "Ticket #{n} by #{c.username}"
      t.author_id = c.id
      t.closed_at = (d += 1).days.ago if (n + 1) / 2 == 0
    end
  end
end
Ticket.import tickets

# Sample messages
messages = []
attendant_ids = Attendant.all.pluck :id
Ticket.all.each do |t|
  4.times do |n|
    author_id = (n + 2) / 2 == 0 ? t.author_id : attendant_ids.sample # customer or attendant
    messages << Ticket::Message.new do |m|
      m.ticket_id = t.id
      m.author_id = author_id
      m.body = "Message by author #{author_id}"
    end
  end
end

Ticket::Message.import messages

puts 'Seeding database finished.'
