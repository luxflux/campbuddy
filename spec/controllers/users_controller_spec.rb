require 'rails_helper'

describe UsersController do
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }

  context 'a guest' do
    describe 'GET show' do
      before do
        user = FactoryBot.create(:user)
        get :show, {:id => user.to_param}
      end

      it { should deny_access }
    end

    describe 'GET new' do
      before do
        get :new
      end

      specify { expect(assigns(:user)).to_not be_persisted }
    end

    describe 'POST create' do
      context 'valid attributes' do
        before do
          post :create, user: valid_attributes
        end

        specify { expect(assigns(:user)).to be_persisted }
        it 'redirects to the root url' do
          expect(response).to redirect_to('/')
        end
      end
    end
  end

  context 'a user' do
    let(:user) { FactoryBot.create(:user) }
    before do
      sign_in_as(user)
    end

    describe "GET show" do
      let(:event) { FactoryBot.create :event }

      before do
        user.events << event
        get :show, {:id => user.to_param}
      end

      specify { expect(assigns(:user)).to eq(user) }
      specify { expect(assigns(:events).map(&:id)).to eq(user.events.in_future.map(&:id)) }
    end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        user = FactoryBot.create(:user)
        get :edit, {:id => user.to_param}
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested user" do
          user = FactoryBot.create(:user)
          # Assuming there are no other users in the database, this
          # specifies that the User created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(User).to receive(:update).with({ "name" => "MyString" })
          put :update, {:id => user.to_param, :user => { "name" => "MyString" }}
        end

        it "assigns the requested user as @user" do
          user = FactoryBot.create(:user)
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = FactoryBot.create(:user)
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(response).to redirect_to(user)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          user = FactoryBot.create(:user)
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(User).to receive(:save).and_return(false)
          put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = FactoryBot.create(:user)
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(User).to receive(:save).and_return(false)
          put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}
          expect(response).to render_template("edit")
        end
      end
    end
  end
end
