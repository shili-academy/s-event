class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :event, null: false, foreign_key: true
      t.references :parent, null: true, references: :tasks, foreign_key: { to_table: :tasks}
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :estimated_costs, default: 0
      t.decimal :actual_costs, default: 0
      t.float :progress, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
