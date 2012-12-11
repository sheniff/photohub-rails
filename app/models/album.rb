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

  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true

  default_scope order: 'albums.created_at DESC'

  def collaborating?(other_user)
    Collaboration.find_by_user_id_and_status(other_user.id, Collaboration::ACCEPTED_STATUS)
  end

  def invited?(other_user)
    Collaboration.find_by_user_id_and_status(other_user.id, Collaboration::PENDING_STATUS)
  end

  def invite!(other_user)
    collaborations.create!(user_id: other_user.id,
              role: Collaboration::COLLABORATOR_ROLE,
              status: Collaboration::PENDING_STATUS) if other_user != user
  end

  def revoke!(other_user)
    collaborations.find_by_user_id(other_user.id).destroy
  end
end
