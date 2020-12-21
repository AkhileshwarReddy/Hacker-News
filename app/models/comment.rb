class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :submission

  validates :content, presence: true
end
