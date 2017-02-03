require 'rails_helper'

RSpec.describe "CallingScripts", type: :request do
  describe "GET /calling_scripts" do
    it "can get the index" do
      get scripts_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /calling_scripts/:id" do
    it "can view the script" do
      @script = FactoryGirl.create(:calling_script)
      get script_path @script
      expect(response).to have_http_status(200)
    end
  end

  
end

