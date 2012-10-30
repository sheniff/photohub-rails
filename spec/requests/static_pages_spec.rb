require 'spec_helper'

describe "StaticPages" do

  it "should have the content 'PhotoHub'" do
    visit '/static_pages/home'
    page.should have_content('PhotoHub')
  end

end
