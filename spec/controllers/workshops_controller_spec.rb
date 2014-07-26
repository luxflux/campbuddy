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

describe WorkshopsController do
  context 'a guest' do
    before do
      get :index
    end

    it { should deny_access }
  end

  context 'a user' do
    before do
      sign_in
    end

    let(:owner) { FactoryGirl.create(:user) }

    # This should return the minimal set of attributes required to create a valid
    # Workshop. As you add validations to Workshop, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { owner_id: owner.id } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # WorkshopsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all workshops as @workshops" do
        workshop = Workshop.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:workshops)).to eq([workshop])
      end
    end

    describe "GET show" do
      it "assigns the requested workshop as @workshop" do
        workshop = Workshop.create! valid_attributes
        get :show, {:id => workshop.to_param}, valid_session
        expect(assigns(:workshop)).to eq(workshop)
      end
    end

    describe "GET new" do
      it "assigns a new workshop as @workshop" do
        get :new, {}, valid_session
        expect(assigns(:workshop)).to be_a_new(Workshop)
      end
    end

    describe "GET edit" do
      it "assigns the requested workshop as @workshop" do
        workshop = Workshop.create! valid_attributes
        get :edit, {:id => workshop.to_param}, valid_session
        expect(assigns(:workshop)).to eq(workshop)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Workshop" do
          expect {
            post :create, {:workshop => valid_attributes}, valid_session
          }.to change(Workshop, :count).by(1)
        end

        it "assigns a newly created workshop as @workshop" do
          post :create, {:workshop => valid_attributes}, valid_session
          expect(assigns(:workshop)).to be_a(Workshop)
          expect(assigns(:workshop)).to be_persisted
        end

        it "redirects to the created workshop" do
          post :create, {:workshop => valid_attributes}, valid_session
          expect(response).to redirect_to(Workshop.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved workshop as @workshop" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Workshop).to receive(:save).and_return(false)
          post :create, {:workshop => { "owner" => "invalid value" }}, valid_session
          expect(assigns(:workshop)).to be_a_new(Workshop)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Workshop).to receive(:save).and_return(false)
          post :create, {:workshop => { "owner" => "invalid value" }}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested workshop" do
          workshop = Workshop.create! valid_attributes
          # Assuming there are no other workshops in the database, this
          # specifies that the Workshop created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(Workshop).to receive(:update).with({ 'owner_id' => owner.id.to_s })
          put :update, {:id => workshop.to_param, :workshop => { owner_id: owner.id }}, valid_session
        end

        it "assigns the requested workshop as @workshop" do
          workshop = Workshop.create! valid_attributes
          put :update, {:id => workshop.to_param, :workshop => valid_attributes}, valid_session
          expect(assigns(:workshop)).to eq(workshop)
        end

        it "redirects to the workshop" do
          workshop = Workshop.create! valid_attributes
          put :update, {:id => workshop.to_param, :workshop => valid_attributes}, valid_session
          expect(response).to redirect_to(workshop)
        end
      end

      describe "with invalid params" do
        it "assigns the workshop as @workshop" do
          workshop = Workshop.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Workshop).to receive(:save).and_return(false)
          put :update, {:id => workshop.to_param, :workshop => { "owner" => "invalid value" }}, valid_session
          expect(assigns(:workshop)).to eq(workshop)
        end

        it "re-renders the 'edit' template" do
          workshop = Workshop.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Workshop).to receive(:save).and_return(false)
          put :update, {:id => workshop.to_param, :workshop => { "owner" => "invalid value" }}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested workshop" do
        workshop = Workshop.create! valid_attributes
        expect {
          delete :destroy, {:id => workshop.to_param}, valid_session
        }.to change(Workshop, :count).by(-1)
      end

      it "redirects to the workshops list" do
        workshop = Workshop.create! valid_attributes
        delete :destroy, {:id => workshop.to_param}, valid_session
        expect(response).to redirect_to(workshops_url)
      end
    end
  end
end
