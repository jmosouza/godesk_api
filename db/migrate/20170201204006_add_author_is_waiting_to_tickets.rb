class AddAuthorIsWaitingToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :author_is_waiting, :bool, null: false, default: true
  end
end
