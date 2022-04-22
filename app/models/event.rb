class Event < ApplicationRecord
  belongs_to :user
  belongs_to :topic, optional: true
  has_many :tasks, dependent: :destroy

  # accepts_nested_attributes_for :tasks

  before_save :add_tasks_with_topic, if: -> {topic}

  private

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
