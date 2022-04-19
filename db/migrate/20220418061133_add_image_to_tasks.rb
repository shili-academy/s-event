class AddImageToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :image, :string
  end
end
