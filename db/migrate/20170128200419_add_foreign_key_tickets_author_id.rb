class AddForeignKeyTicketsAuthorId < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :tickets, :users, column: :author_id
  end
end
