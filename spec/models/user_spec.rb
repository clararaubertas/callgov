require 'rails_helper'


google_hash = OmniAuth::AuthHash.new({
                                       :provider => 'google_oauth2',
                                       :uid => '110031535020051778989',
                                       :info => {
                                         :email => "user2@example.com",
                                         :name => "Barack Obama"
                                       }}
                                    )

facebook_hash = OmniAuth::AuthHash.new ({
                                          :provider => "facebook", 
                                          :uid => 1234, :info => {
                                          :email => "user@example.com",

                                        }}
)

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "creates via omniauth" do
    expect(User.count).to eq(0)
    omniauth_user = User.from_omniauth(facebook_hash)
    expect(User.count).to eq(1)
  end

  it "has a profile" do
    omniauth_user = User.from_omniauth(google_hash)
    profile_url =  "https://plus.google.com/#{google_hash.uid}"
    expect(omniauth_user.profile).to eq profile_url
  end

  it "creates a picture" do
    omniauth_user = User.from_omniauth(google_hash)
    expect(omniauth_user.picture).to be_present
  end

  it "retrieves an existing user" do
    user = User.new(
      :provider => "facebook", 
      :uid => 1234,
      :email => "user@example.com",
      :password => 'password', 
    )
    user.save
    omniauth_user = User.from_omniauth(facebook_hash)
    expect(user).to eq(omniauth_user)
  end
  
end
