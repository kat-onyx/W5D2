# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates_presence_of :url, :title, :content
  validates :subs, presence: { message: 'Must have at least one sub'}

  def top_level_comments
    comments.where(:parent_comment_id => nil).includes(:author).includes(:child_comments)
  end

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs, inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments
end
