class Collaboration < ActiveRecord::Base
  attr_accessible :user_id, :role, :status

  belongs_to :album
  belongs_to :user

  COLLABORATOR_ROLE = 'collaborator'
  VIEWER_ROLE = 'viewer'
  ALL_ROLES = [COLLABORATOR_ROLE, VIEWER_ROLE]

  ACCEPTED_STATUS = 'accepted'
  PENDING_STATUS = 'pending'
  ALL_STATUSES = [ACCEPTED_STATUS, PENDING_STATUS]

  validates :album, presence: true
  validates :user, presence: true
  validates_inclusion_of :role, in: ALL_ROLES
  validates_inclusion_of :status, in: ALL_STATUSES
end
