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

require 'spec_helper'

describe Picture do
  let(:album) { FactoryGirl.create(:album) }
  let(:user) { FactoryGirl.create(:user) }

  include ActionDispatch::TestProcess
  before { @picture = album.pictures.build(name: "Test picture",
                                            user_id: user.id,
                                            image: fixture_file_upload('/images/test.jpg', 'image/jpeg')) }

  subject { @picture }

  it { should respond_to(:name) }
  it { should respond_to(:album_id) }
  it { should respond_to(:user_id) }
  it { should have_attached_file(:image) }
  its(:album) { should == album }

  # it { should validate_attachment_presence(:image) }

  describe "accessible attributes" do
    it "should not allow access to album_id" do
      expect do
        Picture.new(album_id: album.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should not allow access to user_id" do
      expect do
        Picture.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when album_id is not present" do
    before { @picture.album_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @picture.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @picture.name = " " }
    it { should_not be_valid }
  end
end
