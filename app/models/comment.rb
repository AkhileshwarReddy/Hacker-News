class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :submission

  validates :content, presence: true  

  def self.create_child_comment(content, parent_comment_id, user)
    self.transaction do
      parent_comment = self.find(parent_comment_id)
      child_comment = self.new(content: content)
      child_comment.parent_comment_id = parent_comment.id
      child_comment.user = user
      child_comment.submission = parent_comment.submission
      child_comment.save
    end
  end
end
