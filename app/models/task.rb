class Task < ApplicationRecord
  belongs_to :event


  after_create_commit{broadcast_prepend_to :tasks}
  after_update_commit{broadcast_replace_to :tasks}
  after_destroy_commit{broadcast_remove_to :tasks}


  validates :progress, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
