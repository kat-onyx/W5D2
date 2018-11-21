# == Schema Information
#
# Table name: comments
#
#  id                :bigint(8)        not null, primary key
#  content           :string           not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ApplicationRecord
  validates_presence_of :content

  belongs_to :parent_comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    optional: true

  has_many :child_comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :post,
    optional: true
end
