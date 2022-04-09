class TopicTask < ApplicationRecord
  belongs_to :topic
  belongs_to :task
end
