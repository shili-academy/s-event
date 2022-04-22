class Task < ApplicationRecord
  belongs_to :event
  has_one :user, through: :event
  has_many :topic_tasks, dependent: :destroy
  belongs_to :parent_task, class_name: Task.name, foreign_key: :parent_id, optional: true
  has_many :sub_tasks, class_name: Task.name, foreign_key: :parent_id, dependent: :destroy
  mount_uploaders :images, ImagesTaskUploader

  serialize :images, JSON

  enum status: {open: 0, in_progress: 1, pending: 2, completed: 3}

  scope :less_than_or_equal_to, -> date {where "end_time <= ?", date}


  ransacker :start_time, type: :date do
    Arel.sql("date(start_time)")
  end
  ransacker :end_time, type: :date do
    Arel.sql("date(end_time)")
  end

  validates :progress, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validate :check_end_time_less_than_start_time, if: -> {start_time && end_time}

  before_save :add_tasks_with_topic, :add_start_time

  private

  def add_tasks_with_topic
    self.parent_id = nil unless changes.try(:event_id).try(0) == nil

    sub_tasks.each do |task|
      next if task.event_id == event_id

      task.event_id = event_id
    end
  end

  def add_start_time
    return if start_time

    self.start_time = parent_task&.start_time || Time.now
  end

  def check_end_time_less_than_start_time
    errors.add(:end_time, "không thể nhỏ hơn thời gian bắt đầu") if end_time < start_time
  end
end
