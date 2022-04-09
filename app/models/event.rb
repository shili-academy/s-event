class Event < ApplicationRecord
  belongs_to :user
  belongs_to :topic, optional: true
  has_many :tasks, dependent: :destroy

  # accepts_nested_attributes_for :tasks

  after_create_commit{broadcast_prepend_to :events}
  after_update_commit{broadcast_replace_to :events}
  after_destroy_commit{broadcast_remove_to :events}

  before_save :add_tasks_with_topic, if: -> {topic}

  def add_tasks_with_topic
    tasks_topic = self.topic.tasks
    tasks_event = []
    tasks.each do |task|
      next if task.event_id == id
    
      task.event_id = id
    end 
    tasks_topic.each do |task|
      task_dup = task.dup 
      task_dup.event_id = id unless task_dup.id == id
      task_dup.save
      tasks_event << task_dup
    end if changes.has_key?(:topic_id)
    self.tasks << tasks_event
  end
end
