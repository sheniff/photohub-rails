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
