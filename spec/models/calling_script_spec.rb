require 'rails_helper'

RSpec.describe CallingScript, type: :model do


  it "says a user has not called yet" do
    user = FactoryGirl.create(:user)
    script = FactoryGirl.create(:calling_script)
    expect(script.called_yet?(user.id, nil)).to eq false
  end

  it "reports that a user has called after recording call" do
    user = FactoryGirl.create(:user)
    script = FactoryGirl.create(:calling_script)
    expect {
      script.record_call("a_rep_id", user.id)
    }.to change(Call, :count)
    expect(script.called_yet?(user, nil)).to eq true
  end
end
