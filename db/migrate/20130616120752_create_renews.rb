class CreateRenews < ActiveRecord::Migration
  def change
    create_table :renews do |t|
      t.string :jid
      t.integer :user_id
      t.integer :advertise_id
      t.datetime :renew_date
      t.integer :show_for_days
      t.integer :cost

      t.timestamps
    end

    add_index :renews, :user_id
    add_index :renews, :advertise_id
  end
end
