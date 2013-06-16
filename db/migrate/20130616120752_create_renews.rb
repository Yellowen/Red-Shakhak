class CreateRenews < ActiveRecord::Migration
  def change
    create_table :renews do |t|
      t.string :jid
      t.integer :user_id
      t.integer :advertise_id
      t.datetime :renew_date

      t.timestamps
    end
  end
end
