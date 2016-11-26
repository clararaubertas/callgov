require 'rails_helper'

RSpec.describe CallingScript, type: :model do

  it "says a user has not called yet" do
    user = FactoryGirl.create(:user)
    script = FactoryGirl.create(:calling_script)
    expect(script.called_from_this_script?(user)).to eq false
  end

  it "finds whether they called a specific rep" do
    user = FactoryGirl.create(:user)
    script = FactoryGirl.create(:calling_script)
    script.record_call("a_rep_id", user.id)
    expect(script.called_this_rep?(user, "a_rep_id")).to eq true
    expect(script.called_this_rep?(user, "a_diff_rep_id")).to eq false
  end

  it "reports that a user has called after recording call" do
    user = FactoryGirl.create(:user)
    script = FactoryGirl.create(:calling_script)
    expect {
      script.record_call("a_rep_id", user.id)
    }.to change(Call, :count)
    expect(script.called_from_this_script?(user)).to eq true
  end
end
