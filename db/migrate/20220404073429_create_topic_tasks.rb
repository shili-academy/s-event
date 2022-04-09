class CreateTopicTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_tasks do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
