require 'rails_helper'

describe UsersController do

  context 'a guest' do
    before do
      user = FactoryGirl.create(:user)
      get :show, {:id => user.to_param}
    end

    it { should deny_access }
  end

  context 'a user' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in_as(user)
    end

    # This should return the minimal set of attributes required to create a valid
    # User. As you add validations to User, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

    describe "GET show" do
      before do
        get :show, {:id => user.to_param}
      end

      specify { expect(assigns(:user)).to eq(user) }
      specify { expect(assigns(:owned_events)).to eq(user.owned_events.in_future) }
      specify { expect(assigns(:events)).to eq(user.events.in_future) }
    end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        user = FactoryGirl.create(:user)
        get :edit, {:id => user.to_param}
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "POST import" do
      before do
        pending 'Import will be done via console'
      end

      let(:path) { Rails.root.join("spec/fixtures/test_import.csv") }
      let(:file) { Rack::Test::UploadedFile.new(path, "text/csv") }

      describe "with valid params" do
        it "redirects to user list" do
          post :import, file: file
          expect(response).to redirect_to users_path
        end

        it "calls import on User" do
          expect(User).to receive(:import).with(file)
          post :import, file: file
        end
      end

      describe "with invalid params" do
        let(:file) { nil }
        it "redirects to users path" do
          post :import, file: file
          expect(response).to redirect_to users_path
        end

        it "does not call import on User" do
          expect(User).to_not receive(:import)
          post :import, file: file
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested user" do
          user = FactoryGirl.create(:user)
          # Assuming there are no other users in the database, this
          # specifies that the User created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(User).to receive(:update).with({ "name" => "MyString" })
          put :update, {:id => user.to_param, :user => { "name" => "MyString" }}
        end

        it "assigns the requested user as @user" do
          user = FactoryGirl.create(:user)
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = FactoryGirl.create(:user)
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(response).to redirect_to(user)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          user = FactoryGirl.create(:user)
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(User).to receive(:save).and_return(false)
          put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = FactoryGirl.create(:user)
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(User).to receive(:save).and_return(false)
          put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}
          expect(response).to render_template("edit")
        end
      end
    end
  end
end
