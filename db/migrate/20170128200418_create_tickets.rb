class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets, id: false do |t|
      t.primary_key :id, :unsigned_integer, null: false, auto_increment: true
      t.string :title, null: false, index: true
      t.datetime :closed_at, index: true
      t.unsigned_integer :author_id, index: true

      t.timestamps
    end
  end
end
