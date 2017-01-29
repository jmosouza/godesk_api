class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: false do |t|
      t.primary_key :id, :unsigned_integer, null: false, auto_increment: true
      t.string :username, null: false, index: true
      t.string :password_digest, null: false
      t.string :type, null: false, index: true

      t.timestamps
    end
  end
end
