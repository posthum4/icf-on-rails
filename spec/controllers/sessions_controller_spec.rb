require 'spec_helper'

describe SessionsController do

# TODO: 2014-03-11 needs to be rewritten for GApps auth only
  # before(:each) do
  #   OmniAuth.config.test_mode = true
  #   OmniAuth.config.mock_auth[:google] = {
  #       'uid' => 'roland@rocketfuelinc.com',
  #       'provider' => 'google',
  #       'info' => {
  #         'name' => 'Roland'
  #       }
  #     }
  # end

  # describe "GET 'new'" do
  #   it "redirects users to authentication" do
  #     get 'new'
  #     assert_redirected_to '/auth/twitter'
  #   end
  # end

  # describe "creates new user" do
  #   it "redirects new users with blank email to fill in their email" do
  #     @user = FactoryGirl.create(:user)
  #     visit '/signin'
  #     page.should have_content('Logged in as Bob')
  #     page.should have_content('Please enter your email address')
  #     current_path.should == edit_user_path(@user)
  #   end
  #   it "redirects users with email back to root_url" do
  #     @user = FactoryGirl.create(:user, :email => "Tester@testing.com")
  #     visit '/signin'
  #     page.should have_content('Signed in!')
  #     current_path.should == '/'
  #   end
  # end

end
