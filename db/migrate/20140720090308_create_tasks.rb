class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :task_list_id
      t.string :content
      t.boolean :mark
      t.integer :priority

      t.timestamps
    end
    add_index :tasks, :task_list_id
  end
end
