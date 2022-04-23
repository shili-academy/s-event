class Topic < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
