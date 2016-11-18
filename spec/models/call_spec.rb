require 'rails_helper'

RSpec.describe Call, type: :model do

  it "has a representative" do
    call = FactoryGirl.create(:call)
    expect(call).to be_valid
    expect(call.rep).to be_a Sunlight::Legislator
  end
  
end
