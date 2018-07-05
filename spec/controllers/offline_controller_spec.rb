require 'rails_helper'

RSpec.describe OfflineController, type: :controller do
  context 'a guest' do
    describe 'GET show' do
      before do
        user = FactoryBot.create(:user)
        get :show, {:id => user.to_param}
      end

      it { should deny_access }
    end
  end

  context 'a user' do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in_as(user)
    end

    describe 'GET show' do
      let(:event) { FactoryBot.create :event }
      let!(:emergency_numbers) { FactoryBot.create_list :emergency_number, 2 }
      let!(:maps) { FactoryBot.create_list :map, 2 }

      before do
        user.events << event
        get :show
      end

      specify { expect(assigns(:emergency_numbers)).to eq(emergency_numbers) }
      specify { expect(assigns(:events).map(&:id)).to eq(user.events.in_future.map(&:id)) }
      specify { expect(assigns(:maps)).to eq(maps) }
    end
  end
end
