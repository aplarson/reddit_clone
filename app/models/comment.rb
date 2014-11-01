# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
  after_initialize :fetch_post_id
  validates :content, :author, :post, presence: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  belongs_to(
    :parent,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  
  has_many(
    :children,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id
  )
  
  def fetch_post_id
    unless self.persisted?
      self.post_id = parent.post_id if self.parent
    end
  end
end
