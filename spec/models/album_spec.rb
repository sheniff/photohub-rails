require 'spec_helper'

describe Album do

  let(:user) { FactoryGirl.create(:user) }
  before { @album = user.albums.build(title: "Test Album",
                        description: "Lorem ipsum dolor sit amet") }

  subject { @album }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Album.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @album.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @album.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @album.title = "a" * 201 }
    it { should_not be_valid }
  end
end
