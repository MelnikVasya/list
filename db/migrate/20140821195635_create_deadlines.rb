class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.integer :task_id
      t.date :deadline
    end
    add_index :deadlines, :task_id
  end
end
