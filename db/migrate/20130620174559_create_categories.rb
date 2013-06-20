class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :verbose_name

      t.timestamps
    end
  end
end
