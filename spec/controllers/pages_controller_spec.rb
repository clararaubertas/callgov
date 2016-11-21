require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  it "gets the terms page" do
    get :show, :page => :terms
    expect(response.status).to eq 200
  end
end
