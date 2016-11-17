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
     {:content => "Hello", :topic => "Greetings"}
  }

  let(:invalid_attributes) { { :content => nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CallingScriptsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all calling_scripts as @calling_scripts" do
      calling_script = FactoryGirl.create(:calling_script)
      get :index, params: {}, session: valid_session
      expect(assigns(:calling_scripts)).to eq([calling_script])
    end
  end

  describe "GET #show" do
    it "assigns the requested calling_script as @calling_script" do
      calling_script = FactoryGirl.create(:calling_script)
      get :show, id: calling_script.to_param, session: valid_session
      expect(assigns(:calling_script)).to eq(calling_script)
    end
  end
  
  describe "GET #new" do
    it "assigns a new calling_script as @calling_script" do
      get :new, params: {}, session: valid_session
      expect(assigns(:calling_script)).to be_a_new(CallingScript)
    end
  end
  
  describe "GET #edit" do
    it "assigns the requested calling_script as @calling_script" do
      calling_script = FactoryGirl.create(:calling_script)
      get :edit, id: calling_script.to_param, session: valid_session
      expect(assigns(:calling_script)).to eq(calling_script)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new CallingScript" do
        expect {
          post :create, calling_script: valid_attributes, session: valid_session
        }.to change(CallingScript, :count).by(1)
      end
      
      it "assigns a newly created calling_script as @calling_script" do
        post :create, calling_script: valid_attributes, session: valid_session
        expect(assigns(:calling_script)).to be_a(CallingScript)
        expect(assigns(:calling_script)).to be_persisted
      end
      
      it "redirects to the created calling_script" do
        post :create, calling_script: valid_attributes, session: valid_session
        expect(response).to redirect_to(CallingScript.last)
      end
    end
    
    context "with invalid params" do
      it "assigns a newly created but unsaved calling_script as @calling_script" do
        post :create, calling_script: invalid_attributes, session: valid_session
        expect(assigns(:calling_script)).to be_a_new(CallingScript)
      end
      
      it "re-renders the 'new' template" do
        post :create, calling_script: invalid_attributes, session: valid_session
        expect(response).to render_template("new")
      end
    end
    end
    
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryGirl.attributes_for(:calling_script)
      }
      
      it "updates the requested calling_script" do
        calling_script = FactoryGirl.create(:calling_script)
        put :update,  id: calling_script.to_param, calling_script: new_attributes, session: valid_session
        calling_script.reload
        skip("Add assertions for updated state")
      end
      
      it "assigns the requested calling_script as @calling_script" do
        calling_script = FactoryGirl.create(:calling_script)
        put :update, id: calling_script.to_param, calling_script: valid_attributes, session: valid_session
        expect(assigns(:calling_script)).to eq(calling_script)
      end

      it "redirects to the calling_script" do
        calling_script = CallingScript.create! valid_attributes
        put :update,  id: calling_script.to_param, calling_script: valid_attributes, session: valid_session
        expect(response).to redirect_to(calling_script)
      end
    end

    context "with invalid params" do
      it "assigns the calling_script as @calling_script" do
        calling_script = CallingScript.create! valid_attributes
        put :update,  id: calling_script.to_param, calling_script: invalid_attributes, session: valid_session
        expect(assigns(:calling_script)).to eq(calling_script)
      end

      it "re-renders the 'edit' template" do
        calling_script = CallingScript.create! valid_attributes
        put :update,  id: calling_script.to_param, calling_script: invalid_attributes, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested calling_script" do
      calling_script = CallingScript.create! valid_attributes
      expect {
        delete :destroy,  id: calling_script.to_param, session: valid_session
      }.to change(CallingScript, :count).by(-1)
    end

    it "redirects to the calling_scripts list" do
      calling_script = CallingScript.create! valid_attributes
      delete :destroy, id: calling_script.to_param, session: valid_session
      expect(response).to redirect_to(calling_scripts_url)
    end
  end

end
