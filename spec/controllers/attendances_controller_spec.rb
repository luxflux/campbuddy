require 'rails_helper'

describe AttendancesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  let(:attendance) { FactoryGirl.create(:attendance, user: user, event: event) }

  context 'a guest' do
    before do
      get :show, {:id => attendance.to_param}
    end

    it { should deny_access }
  end

  context 'a user' do
    before do
      sign_in
    end

    describe 'GET show' do
      it 'assigns the requested attendance as @attendance' do
        get :show, {:id => attendance.to_param}
        expect(assigns(:attendance)).to eq(attendance)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Attendance' do
          expect {
            post :create, {:attendance => { user_id: user.id, event_id: event.id } }
          }.to change(Attendance, :count).by(1)
        end

        it 'assigns a newly created attendance as @attendance' do
          post :create, {:attendance => { user_id: user.id, event_id: event.id } }
          expect(assigns(:attendance)).to be_a(Attendance)
          expect(assigns(:attendance)).to be_persisted
        end

        it 'renders the created attendance' do
          post :create, {:attendance => { user_id: user.id, event_id: event.id } }
          expect(response.status).to eq(200)
        end
      end

      describe 'with invalid params' do
        it 'returns a status of 422' do
          post :create, {:attendance => { 'user' => 'invalid value' }}
          expect(response.status).to eq(422)
        end
      end
    end

    describe 'DELETE destroy' do
      before do
        attendance.save!
      end

      it 'destroys the requested attendance' do
        expect {
          delete :destroy, {:id => attendance.to_param}
        }.to change(Attendance, :count).by(-1)
      end

      it 'redirects to the attendances list' do
        delete :destroy, {:id => attendance.to_param}
        expect(response.status).to eq(201)
      end
    end
  end
end
