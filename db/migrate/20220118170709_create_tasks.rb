class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :estimated_costs
      t.decimal :actual_costs
      t.string :location
      t.float :progress, default: 0

      t.timestamps
    end
  end
end
