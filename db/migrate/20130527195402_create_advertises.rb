class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.string :title
      t.text :description
      t.integer :show_for_days, default: 0
      t.integer :cost, default: 0
      t.integer :user_id
      t.datetime :deactive_date
      t.float :cost_per_day

      t.timestamps
    end

    add_index :advertises, :cost_per_day
  end
end
