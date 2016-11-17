require 'rails_helper'

RSpec.describe "calling_scripts/index", type: :view do
  before(:each) do
    assign(:calling_scripts, [
      CallingScript.create!(
        :content => "MyText",
        :topic => "Topic"
      ),
      CallingScript.create!(
        :content => "MyText",
        :topic => "Topic"
      )
    ])
  end

  it "renders a list of calling_scripts" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Topic".to_s, :count => 2
  end
end
