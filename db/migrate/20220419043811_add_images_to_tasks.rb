class AddImagesToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :images, :string
  end
end
