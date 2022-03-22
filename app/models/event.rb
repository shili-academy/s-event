class Event < ApplicationRecord
  belongs_to :user
  belongs_to :event_type
  has_many :tasks, dependent: :destroy

  after_create_commit{broadcast_prepend_to :events}
  after_update_commit{broadcast_replace_to :events}
  after_destroy_commit{broadcast_remove_to :events}
end
