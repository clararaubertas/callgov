require 'rails_helper'

RSpec.describe "calling_scripts/edit", type: :view do
  before(:each) do
    @calling_script = assign(:calling_script, CallingScript.create!(
      :content => "MyText",
      :topic => "MyString"
    ))
  end

  it "renders the edit calling_script form" do
    render

    assert_select "form[action=?][method=?]", calling_script_path(@calling_script), "post" do

      assert_select "textarea#calling_script_content[name=?]", "calling_script[content]"

      assert_select "input#calling_script_topic[name=?]", "calling_script[topic]"
    end
  end
end
