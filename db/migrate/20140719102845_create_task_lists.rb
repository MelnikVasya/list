class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.integer :user_id
      t.string :header
      t.timestamps
    end
    add_index :task_lists, :user_id
  end
end
