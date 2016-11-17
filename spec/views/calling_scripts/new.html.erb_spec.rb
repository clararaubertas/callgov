require 'rails_helper'

RSpec.describe "calling_scripts/new", type: :view do
  before(:each) do
    assign(:calling_script, CallingScript.new(
      :content => "MyText",
      :topic => "MyString"
    ))
  end

  it "renders new calling_script form" do
    render

    assert_select "form[action=?][method=?]", calling_scripts_path, "post" do

      assert_select "textarea#calling_script_content[name=?]", "calling_script[content]"

      assert_select "input#calling_script_topic[name=?]", "calling_script[topic]"
    end
  end
end
