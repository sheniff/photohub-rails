# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  user_id            :integer
#  album_id           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Picture < ActiveRecord::Base
  attr_accessible :name, :image
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :album
  belongs_to :user

  validates :album_id, presence: true
  validates :name, presence: true, allow_blank: false

  validates :image, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :image
end
