require 'rails_helper'

RSpec.describe "calling_scripts/show", type: :view do
  before(:each) do
    @calling_script = assign(:calling_script, CallingScript.create!(
      :content => "MyText",
      :topic => "Topic"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Topic/)
  end
end
