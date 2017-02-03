require 'rails_helper'

RSpec.describe CallingScriptsController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:calling_script)
  }

  let(:invalid_attributes) { { :content => nil }
  }

  describe "GET #index" do
    before(:each) do 
      3.times { FactoryGirl.create(:calling_script) }
      @size = CallingScript.all.size
    end
    it "assigns all calling_scripts as @calling_scripts" do
      get :index, params: {}
      expect(assigns(:calling_scripts).size).to eq @size
    end
    it "finds scripts by search" do
      get :index, :search => CallingScript.first.topic.split.first 
      expect(assigns(:calling_scripts).size).to be < @size
    end
    it "shows an error when nothing is present" do
      get :index, :search => "A string that will not get randomly generated" 
      expect(flash[:error]).to be_present
    end
  end

  describe "POST #archive" do
    before(:each) do
      @calling_script = FactoryGirl.create(:calling_script)
      @user = FactoryGirl.create(:user)
    end

    it "should not allow archiving if it is not an admin" do
      sign_in(@user)
      expect {
        post :archive, id: @calling_script.to_param
        @calling_script.reload
      }.not_to change(@calling_script, :archived)
    end

    it "should allow archiving if it is an admin" do
      @user.update_attribute(:admin, true)
      sign_in(@user)
      expect {
        post :archive, id: @calling_script.to_param
        @calling_script.reload
      }.to change(@calling_script, :archived)
    end
    
  end
  
  describe "GET #show" do
    before(:each) do
      @calling_script = FactoryGirl.create(:calling_script)
      @call = FactoryGirl.create(:call)
      @user = FactoryGirl.create(:user)
    end
    describe "before calling" do
      it "assigns the requested calling_script as @calling_script" do
        get :show, id: @calling_script.to_param
        expect(assigns(:calling_script)).to eq(@calling_script)
      end
      it "assigns a representative if appropriate" do
        get :show, id: @calling_script.to_param, :rep_id => @call.rep_id
        expect(assigns(:representative).first_name).to eq @call.rep.first_name
      end
      it "gets several reps with an address" do
        get :show,
            id: @calling_script.to_param,
            :address => "5509 S Hyde Park #3 Chicago IL 60637"
        expect(assigns(:representatives).size).to eq 3
      end
      it "can't get reps with no address" do
        get :show,
            id: @calling_script.to_param,
            :address => " "
        expect(flash[:error]).to be_present
      end
    end
    
    describe "after calling" do
      subject {
        get :show,
            id: @calling_script.to_param,
            :i_called => true,
            :rep_id => FactoryGirl.create(:call).rep_id,
            :address => "5509 S Hyde Park #3 Chicago IL 60637"
      }

      it "creates a call" do
        expect {
          subject
        }.to change(Call, :count)
      end
      
      it "redirects to the script" do
        sign_in(@user)
        2.times {
          FactoryGirl.create(:call,
                             :user_id => @user.id,
                             :calling_script_id => @calling_script.id) }
        expect(subject).to render_template(:show) 
      end
      it "redirects back after 3 reps" do
        sign_in(@user)
        3.times { FactoryGirl.create(:call,
                                     :user_id => @user.id,
                                     :calling_script_id => @calling_script.id) }
        expect(subject).to redirect_to(scripts_path) 
      end
    end
  end
  
  describe "GET #new" do
    it "assigns a new calling_script as @calling_script" do
      sign_in(FactoryGirl.create(:user))
      get :new, params: {}
      expect(assigns(:calling_script)).to be_a_new(CallingScript)
    end
  end
  
  describe "GET #edit" do
    it "assigns the requested calling_script as @calling_script" do
      calling_script = FactoryGirl.create(:calling_script)
      sign_in(calling_script.user)
      get :edit, id: calling_script.to_param
      expect(assigns(:calling_script)).to eq(calling_script)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new CallingScript" do
        expect {
          post :create, calling_script: valid_attributes
        }.to change(CallingScript, :count).by(1)
      end
       before(:each) do
        sign_in(FactoryGirl.create(:user))
      end
      
      it "assigns a newly created calling_script as @calling_script" do
        post :create, calling_script: valid_attributes
        expect(assigns(:calling_script)).to be_a(CallingScript)
        expect(assigns(:calling_script)).to be_persisted
      end
      
      it "redirects to the created calling_script" do
        post :create, calling_script: valid_attributes
        expect(response).to redirect_to(script_path(CallingScript.last))
      end
    end

    context 'with no user' do
      it "denies access" do
        post :create, calling_script: valid_attributes
        expect(response).to redirect_to(new_user_registration_url) 
      end
    end
    
    context "with invalid params" do
      before(:each) do
        sign_in(FactoryGirl.create(:user))
      end

      it "assigns a newly created script as @calling_script" do
        post :create, calling_script: invalid_attributes
        expect(assigns(:calling_script)).to be_a_new(CallingScript)
      end
      
      it "re-renders the 'new' template" do
        post :create, calling_script: invalid_attributes
        expect(response).to render_template("new")
      end
    end
    end
    
  describe "PUT #update" do
    before(:each) do
      @calling_script = FactoryGirl.create(:calling_script)
      sign_in(@calling_script.user)
    end
    context "with valid params" do
      let(:new_attributes) {
        FactoryGirl.attributes_for(:calling_script).merge(:topic => "foo")
      }
      before(:each) do
        put :update,
            id: @calling_script.to_param,
            calling_script: new_attributes
      end
      it "updates the requested calling_script" do
        @calling_script.reload
        expect(@calling_script.topic).to eq "foo"
      end
      it "assigns the requested calling_script as @calling_script" do
        expect(assigns(:calling_script)).to eq(@calling_script)
      end
      it "redirects to the calling_script" do
        expect(response).to redirect_to(script_path(@calling_script))
      end
    end

    context "with invalid params" do
      before(:each) do
        put :update,
            id: @calling_script.to_param,
            calling_script: invalid_attributes
      end
      it "assigns & redirects" do
        expect(assigns(:calling_script)).to eq(@calling_script)
      end
      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end
    end
  end


  describe "DELETE #destroy" do
    it "destroys the requested calling_script" do
      calling_script = FactoryGirl.create(:calling_script)
      sign_in(calling_script.user)
      expect {
        delete :destroy,
               id: calling_script.to_param
      }.to change(CallingScript, :count).by(-1)
    end

    it "redirects to the calling_scripts list" do
      calling_script = FactoryGirl.create(:calling_script)
      sign_in(calling_script.user)
      delete :destroy, id: calling_script.to_param
      expect(response).to redirect_to(scripts_url)
    end
  end

end
