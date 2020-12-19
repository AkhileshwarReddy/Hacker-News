class Submission < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :text, length: { maximum: 2000 }

  def self.newest
    Submission.order(created_at: :desc)
  end
end
