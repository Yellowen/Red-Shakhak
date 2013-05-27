class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|
      t.string :title
      t.string :description
      t.integer :show_for_days
      t.integer :cost

      t.timestamps
    end
  end
end
