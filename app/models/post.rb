class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true

  def user
    User.find_by(id: self.user_id)
  end

  def likes
    Like.where(post_id: self.id)
  end
end
