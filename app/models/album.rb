class Album < ActiveRecord::Base
  attr_accessible :title, :description
  belongs_to :user
  has_many :pictures, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true

  default_scope order: 'albums.created_at DESC'
end
