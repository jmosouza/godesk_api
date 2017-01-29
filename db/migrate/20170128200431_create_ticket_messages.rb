class CreateTicketMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_messages do |t|
      t.string :body
      t.unsigned_integer :author_id, index: true, null: false
      t.unsigned_integer :ticket_id, index: true, null: false

      t.timestamps
    end
  end
end
