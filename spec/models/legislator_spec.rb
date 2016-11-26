require 'rails_helper'

RSpec.describe Legislator, type: :model do

  it "has a party name" do
    rep = Legislator.new(:party => 'R')
    expect(rep.party_name).to eq 'republican'
    rep.party = 'D'
    expect(rep.party_name).to eq 'democrat'
  end

  it "gets a picture from twitter" do
    rep = Legislator.new(:twitter_id => 'twittername')
    expect(rep.display_image).to be_a String
  end

  it "gets a picture from facebook" do
    rep = Legislator.new(:facebook_id => 'fbname')
    expect(rep.display_image).to be_a String
  end

  it "has a display name" do
    rep = Legislator.new(:first_name => 'Joe', :last_name => 'Blow')
    expect(rep.display_name).to be_a String
  end

  
end
