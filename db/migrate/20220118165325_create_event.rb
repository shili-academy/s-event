class CreateEvent < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :happen_at

      t.timestamps
    end
  end
end
