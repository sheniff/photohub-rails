require 'spec_helper'

describe Collaboration do

  let(:album) { FactoryGirl.create(:album) }
  let(:user) { FactoryGirl.create(:user) }
  let(:collaboration) { album.collaborations.build(user_id: user.id, role: Collaboration::COLLABORATOR_ROLE, status: Collaboration::PENDING_STATUS) }

  subject { collaboration }

  it { should be_valid }

  it { should respond_to (:role) }
  it { should respond_to (:status) }
  # relations
  it { should respond_to (:album) }
  it { should respond_to (:user) }

  describe "accessible attributes" do
    it "should not allow access to album_id" do
      expect do
        Collaboration.new(album_id: album.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user id is not present" do
    before { collaboration.user_id = nil }
    it { should_not be_valid }
  end

  describe "when album id is not present" do
    before { collaboration.album_id = nil }
    it { should_not be_valid }
  end

  describe "when role is not valid" do
    before { collaboration.role = "fake_role" }
    it { should_not be_valid }
  end

  describe "when status is not valid" do
    before { collaboration.status = "fake_status" }
    it { should_not be_valid }
  end
end
