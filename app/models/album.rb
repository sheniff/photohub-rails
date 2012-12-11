# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Album < ActiveRecord::Base
  attr_accessible :title, :description
  belongs_to :user
  has_many :pictures, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true

  default_scope order: 'albums.created_at DESC'
end
