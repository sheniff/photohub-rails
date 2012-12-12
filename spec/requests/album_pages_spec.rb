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

  describe "album sharing" do
    let(:album) { FactoryGirl.create(:album, user: user) }

    describe "inviting collaborator" do
      let(:another_user) { FactoryGirl.create(:user) }

      it "should invite a new user to share the album" do
        expect { post invite_to_album_path(album,another_user) }.to change(Collaboration, :count).by(1)
      end

      it "should not be possible for the owner to invite himself" do
        expect { post invite_to_album_path(album, user) }.not_to change(Collaboration, :count)
      end

      describe "as an incorrect user" do
        before { sign_in another_user }

        it "should not be able to invite anybody" do
          expect { post invite_to_album_path(album, another_user) }.not_to change(Collaboration, :count)
        end
      end
    end

    describe "showing user lists" do
      let(:another_user) { FactoryGirl.create(:user) }
      let(:collaboration) { album.collaborations.create(user_id: another_user.id, role: Collaboration::COLLABORATOR_ROLE, status: Collaboration::PENDING_STATUS) }

      describe "invitations" do
        before { visit invitations_album_path(album) }
        it { should have_content(collaboration.album.title) }
        it { should have_link('Revoke') }
        it { should have_link('Invite friend') }

        describe "an user different than the onwer" do
          before do
            sign_in another_user
            visit invitations_album_path(album)
          end
          it { should_not have_link('Invite friend') }
        end
      end

      describe "collaborators" do
        before do
          sign_in another_user
          post accept_collaboration_path(collaboration)
          sign_in user
          visit collaborators_album_path(album)
        end
        it { should have_content(collaboration.album.title) }
        it { should have_link('Uninvite') }
        it { should have_link('Invite friend') }

        describe "an user different than the onwer" do
          before do
            sign_in another_user
            visit collaborators_album_path(album)
          end
          it { should_not have_link('Uninvite') }
          it { should_not have_link('Invite friend') }
        end
      end
    end
  end

  describe "collaborating in an album" do
    include ActionDispatch::TestProcess
    before { sign_in user }
    let(:album) { FactoryGirl.create(:album, user: user) }
    let(:another_user) { FactoryGirl.create(:user) }

    describe "a non-collaborator user" do
      it "should not be able to add pictures" do
        expect do
          album.pictures.create(name: "Test picture",
                        user_id: another_user.id,
                        image: fixture_file_upload('/images/test.jpg', 'image/jpeg'))
        end.not_to change(Picture, :count)
      end
    end

    describe "an invited user" do
      let(:collaboration) { album.collaborations.create(user_id: another_user.id, role: Collaboration::COLLABORATOR_ROLE, status: Collaboration::PENDING_STATUS) }
      it "should not be able to add picture yet" do
        expect do
          album.pictures.create(name: "Test picture",
                        user_id: another_user.id,
                        image: fixture_file_upload('/images/test.jpg', 'image/jpeg'))
        end.not_to change(Picture, :count)
      end

      describe "once he accept the invitation" do
        before { post accept_collaboration_path(path) }
        it "should be able to add pictures to that album" do
          expect do
            album.pictures.create(name: "Test picture",
                          user_id: another_user.id,
                          image: fixture_file_upload('/images/test.jpg', 'image/jpeg'))
          end.to change(Picture, :count).by(1)
        end
      end
    end
  end
end
