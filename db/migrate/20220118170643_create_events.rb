class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.datetime :happen_at
      t.string :location

      t.timestamps
    end
  end
end
