class AddForeignKeyTicketMessagesTicketId < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :ticket_messages, :users, column: :author_id
    add_foreign_key :ticket_messages, :tickets, column: :ticket_id
  end
end
