require 'rails_helper'

RSpec.feature "SignIns", type: :feature do


  before do
    hash =  OmniAuth::AuthHash.new({
                                     :provider => 'twitter',
                                     :uid => '123545',
                                     :info => {
                                       :name => "Jane Doe",
                                       :email => "jane@example.com"
                                     }})
    OmniAuth.config.mock_auth[:twitter] = hash
    OmniAuth.config.mock_auth[:facebook] = hash
    OmniAuth.config.mock_auth[:google_oauth2] = hash
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:twitter]
  end

  let(:user) { create(:user) }

  before(:each) do
    visit '/'
    expect(page).to have_no_content 'Logout'    
  end

  scenario "can't authenticate" do
    OmniAuth.config.mock_auth[:twitter] = :nothing
    click_link 'Sign in with Twitter' # image/button: Sign in with Twitter
    expect(page).to have_content "Could not authenticate"
    expect(page).to have_no_content 'Logout'
  end
  
  scenario 'with valid email and password, Twitter' do
    click_link 'Sign in with Twitter' # image/button: Sign in with Twitter
    expect(page).to have_content 'Successfully authenticated from Twitter'
    expect(page).to have_content 'Logout'
  end

  scenario "with Google" do
    click_link 'Sign in with Google' # image/button: Sign in with Google
    expect(page).to have_content 'Successfully authenticated from Google'
  end

  scenario "with Facebook" do
    click_link 'Sign in with Facebook' # image/button: Sign in with LinkedIn
    expect(page).to have_content 'Successfully authenticated from Facebook'
  end
  
end
