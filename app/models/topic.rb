class Topic < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :topic_tasks, dependent: :destroy
  
  has_many :tasks, through: :topic_tasks



  # acts_as_paranoid
end
