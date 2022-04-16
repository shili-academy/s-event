class Task < ApplicationRecord
  belongs_to :event
  has_many :topic_tasks, dependent: :destroy
  belongs_to :parent_task, class_name: Task.name, foreign_key: :parent_id, optional: true
  has_many :sub_tasks, class_name: Task.name, foreign_key: :parent_id, dependent: :destroy

  after_create_commit{broadcast_prepend_to :tasks}
  after_update_commit{broadcast_replace_to :tasks}
  after_destroy_commit{broadcast_remove_to :tasks}

  validates :progress, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  before_save :add_tasks_with_topic

  def add_tasks_with_topic 
    self.parent_id = nil unless changes.try(:event_id).try(0) == nil
  
    sub_tasks.each do |task|
      next if task.event_id == event_id
      
      task.event_id = event_id
    end    
  end
end
