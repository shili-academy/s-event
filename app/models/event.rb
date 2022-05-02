class Event < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }


  belongs_to :user
  belongs_to :topic, optional: true
  has_many :tasks, dependent: :destroy

  enum status: {open: 0, in_progress: 1, pending: 2, completed: 3}

  before_save :add_tasks_with_topic, if: -> {topic}

  private

  def add_tasks_with_topic
    tasks_topic = self.topic.tasks.where(parent_id: nil)
    @tasks_event = []
    tasks_topic.each do |task|
      task_dup = task.dup
      task_dup.event_id = id
      task_dup.topic_id = nil
      task_dup.start_time = Time.now
      task_dup.save
      @tasks_event << task_dup
      dup_sub_tasks task, task_dup.id
    end if changes.has_key?(:topic_id)
    self.tasks << @tasks_event
  end

  def dup_sub_tasks task, task_dup_id
    task.sub_tasks.each do |task|
      task_dup = task.dup
      task_dup.event_id = id
      task_dup.topic_id = nil
      task_dup.start_time = Time.now
      task_dup.parent_id = task_dup_id
      task_dup.save
      @tasks_event << task_dup
      dup_sub_tasks task, task_dup.id
    end
  end
end
