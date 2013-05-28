class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.string :title
      t.string :description
      t.integer :show_for_days
      t.integer :cost
      t.integer :user_id

      t.timestamps
    end
  end
end
