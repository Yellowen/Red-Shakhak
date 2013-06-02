class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.references :logable, index: true, :polymorphic => true
      t.string :msg

      t.timestamps
    end

    add_index :logs, :user_id
  end
end
