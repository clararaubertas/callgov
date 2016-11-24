require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CallingScriptsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # CallingScript. As you add validations to CallingScript, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:calling_script)
  }

  let(:invalid_attributes) { { :content => nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CallingScriptsController. Be sure to keep this updated too.

  

  describe "GET #index" do
    it "assigns all calling_scripts as @calling_scripts" do 
     calling_script = FactoryGirl.create(:calling_script)
      get :index, params: {}
      expect(assigns(:calling_scripts)).to eq([calling_script])
    end
  end

  describe "GET #show" do
    it "assigns the requested calling_script as @calling_script" do
      calling_script = FactoryGirl.create(:calling_script)
      get :show, id: calling_script.to_param
      expect(assigns(:calling_script)).to eq(calling_script)
    end
    it "assigns a representative if appropriate" do
      calling_script = FactoryGirl.create(:calling_script)
      call = FactoryGirl.create(:call)
      get :show, id: calling_script.to_param, :rep_id => call.rep_id
      expect(assigns(:representative).first_name).to eq call.rep.first_name
    end
    it "gets several reps with an address" do
      calling_script = FactoryGirl.create(:calling_script)
      get :show, id: calling_script.to_param, :address => "5509 S Hyde Park #3 Chicago IL 60637"
      expect(assigns(:representatives).size).to eq 3
    end
    it "creates a call" do
      calling_script = FactoryGirl.create(:calling_script)
      expect {
        get :show, id: calling_script.to_param, :rep_id => FactoryGirl.create(:call).rep_id, :i_called => true
      }.to change(Call, :count)
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

      it "assigns a newly created but unsaved calling_script as @calling_script" do
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
    context "with valid params" do
      let(:new_attributes) {
        FactoryGirl.attributes_for(:calling_script).merge(:topic => "foo")
      }

      before(:each) do
      end
      
      it "updates the requested calling_script" do
        calling_script = FactoryGirl.create(:calling_script)
        sign_in(calling_script.user)
        put :update,  id: calling_script.to_param, calling_script: new_attributes
        calling_script.reload
        expect(calling_script.topic).to eq "foo"
      end
      
      it "assigns the requested calling_script as @calling_script" do
        calling_script = FactoryGirl.create(:calling_script)
        sign_in(calling_script.user)
        put :update, id: calling_script.to_param, calling_script: valid_attributes
        expect(assigns(:calling_script)).to eq(calling_script)
      end

      it "redirects to the calling_script" do
        calling_script = FactoryGirl.create(:calling_script)
        sign_in(calling_script.user)
        put :update,  id: calling_script.to_param, calling_script: valid_attributes
        expect(response).to redirect_to(script_path(calling_script))
      end
    end

    context "with invalid params" do
      it "assigns the calling_script as @calling_script" do
        calling_script = FactoryGirl.create(:calling_script)
        sign_in(calling_script.user)
        put :update,  id: calling_script.to_param, calling_script: invalid_attributes
        expect(assigns(:calling_script)).to eq(calling_script)
      end

      it "re-renders the 'edit' template" do
        calling_script = FactoryGirl.create(:calling_script)
        sign_in(calling_script.user)
        put :update,  id: calling_script.to_param, calling_script: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested calling_script" do
      calling_script = FactoryGirl.create(:calling_script)
      sign_in(calling_script.user)
      expect {
        delete :destroy,  id: calling_script.to_param      }.to change(CallingScript, :count).by(-1)
    end

    it "redirects to the calling_scripts list" do
      calling_script = FactoryGirl.create(:calling_script)
      sign_in(calling_script.user)
      delete :destroy, id: calling_script.to_param
      expect(response).to redirect_to(scripts_url)
    end
  end

end
