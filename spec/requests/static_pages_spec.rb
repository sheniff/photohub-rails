require 'spec_helper'

describe "StaticPages" do

  subject { page }
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)     { "PhotoHub" }
    let(:page_title)  { "" }

    it_should_behave_like "all static pages"
    it { should_not have_selector('title', text: '| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:album, user: user, title: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.")
        FactoryGirl.create(:album, user: user, title: "Dolor Sit Amet", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.title)
        end
      end

      it { should have_selector('span.count', text: "#{user.albums.count} albums") }

    end

    describe "pagination" do
      let(:user) { FactoryGirl.create(:user) }
      before(:all) do
        30.times { FactoryGirl.create(:album, user: user) }
        sign_in user
        visit root_path
      end
      after(:all) { user.delete }

      it { should have_selector('div', class: "pagination") }

      it "should list each album" do
        Album.paginate(page: 1).each do |album|
          page.should have_selector('li', text: album.title)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)     { "Help" }
    let(:page_title)  { "Help" }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)     { "Contact" }
    let(:page_title)  { "Contact" }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign Up')
    click_link "PhotoHub"
    page.should have_selector 'title', text: full_title('')
  end
end
