class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: true, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :happen_at
      t.string :location

      t.timestamps
    end
  end
end
