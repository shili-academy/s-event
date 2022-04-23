class TopicTask < ApplicationRecord
  belongs_to :topic
  has_many :tasks, dependent: :destroy
end
