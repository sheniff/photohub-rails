require 'spec_helper'

describe "AlbumPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "album creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create an album" do
        expect { click_button "New Album" }.not_to change(Album, :count)
      end

      describe "error messages" do
        before { click_button "New Album" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
         fill_in 'album_title', with: "Lorem Ipsum"
         fill_in 'album_description', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
       end
       it "should create an album" do
        expect { click_button "New Album" }.to change(Album, :count).by(1)
       end
    end
  end

  describe "album destruction" do
    before { FactoryGirl.create(:album, user: user) }

    describe "as correct user" do
      before { visit root_path }
      it "should delete an album" do
        expect { click_link "delete" }.to change(Album, :count).by(-1)
      end
    end

    describe "as an incorrect user" do
      let(:incorrect_user) { FactoryGirl.create(:user, email: "incorrect@example.org") }
      before { visit user_path(incorrect_user) }
      it { should_not have_selector('a', text: 'delete') }
    end
  end
end
