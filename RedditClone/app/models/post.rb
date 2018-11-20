# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :string           not null
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates_presence_of :url, :title, :content

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :sub
end
