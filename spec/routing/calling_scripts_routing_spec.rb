require "rails_helper"

RSpec.describe CallingScriptsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/calling_scripts").to route_to("calling_scripts#index")
    end

    it "routes to #new" do
      expect(:get => "/calling_scripts/new").to route_to("calling_scripts#new")
    end

    it "routes to #show" do
      expect(:get => "/calling_scripts/1").to route_to("calling_scripts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/calling_scripts/1/edit").to route_to("calling_scripts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/calling_scripts").to route_to("calling_scripts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/calling_scripts/1").to route_to("calling_scripts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/calling_scripts/1").to route_to("calling_scripts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/calling_scripts/1").to route_to("calling_scripts#destroy", :id => "1")
    end

  end
end
