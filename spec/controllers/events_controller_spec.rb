require 'rails_helper'

describe EventsController do
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
    let(:category) { FactoryGirl.create(:category) }

    describe "GET index" do
      it 'assigns events as @events' do
        event = FactoryGirl.create(:event)
        get :index, { date: event.starts }
        expect(assigns(:events)).to eq([event])
      end

      it 'does not assign group events as @events' do
        event = FactoryGirl.create(:event, groups_only: true)
        get :index, { date: event.starts }
        expect(assigns(:events)).to_not include(event)
      end

      it 'assigns all the categories of the events as @categories' do
        category1 = FactoryGirl.create(:category, identifier: :red)
        category2 = FactoryGirl.create(:category, identifier: :yellow)
        FactoryGirl.create(:event, category: category2, starts: Setting.camp_start)
        event = FactoryGirl.create(:event, category: category1)

        Timecop.travel Setting.camp_start + 2.days

        get :index, { date: event.starts }
        expect(assigns(:categories)).to eq([category1])
      end

      context 'without a date selected' do
        context 'current date in camp timeframe' do
          before do
            Timecop.travel Setting.camp_start + 1.day
          end

          it 'assigns the current date as selection' do
            get :index, {}
            expect(assigns(:selected_date)).to eq(Date.current)
          end
        end

        context 'current date before camp timeframe' do
          before do
            Timecop.travel Setting.camp_start - 1.day
          end

          it 'assigns the camp start date as selection' do
            get :index, {}
            expect(assigns(:selected_date)).to eq(Setting.camp_start)
          end
        end

        context 'current date after camp timeframe' do
          before do
            Timecop.travel Setting.camp_end + 7.days
          end

          it 'assigns the camp start date as selection' do
            get :index, {}
            expect(assigns(:selected_date)).to eq(Setting.camp_end)
          end
        end
      end

      context 'with an invalid date selected' do
        before do
          Timecop.travel Setting.camp_start + 1.day
        end

        it 'assigns the current date as selection' do
          get :index, { date: 'asd' }
          expect(assigns(:selected_date)).to eq(Date.current)
        end
      end

      context 'with an valid date selected' do
        it 'assigns the date as selection' do
          get :index, { date: Setting.camp_start + 1.day }
          expect(assigns(:selected_date)).to eq(Setting.camp_start + 1.day)
        end
      end
    end

    describe 'GET catalog' do
      it 'assigns all Events in the future as @events' do
        passed_event = FactoryGirl.create(:event, starts: Setting.camp_start + 1.hour)
        future_event = FactoryGirl.create(:event, starts: Setting.camp_start + 3.hours)

        Timecop.travel Setting.camp_start + 2.hours

        get :catalog
        expect(assigns(:events)).to eq([future_event])
      end

      it 'does not fetch mandatory events' do
        category = FactoryGirl.create(:category, mandatory_events: true)
        mandatory_event = FactoryGirl.create(:event, category: category)
        get :catalog
        expect(assigns(:events)).to eq([])
      end

      it 'does not fetch group events' do
        group_event = FactoryGirl.create(:event, groups_only: true)
        get :catalog
        expect(assigns(:events)).to eq([])
      end

      it 'does not fetch info events' do
        category = FactoryGirl.create(:category, info_events: true)
        info_event = FactoryGirl.create(:event, category: category)
        get :catalog
        expect(assigns(:events)).to eq([])
      end

      it 'assigns all the categories of the events as @categories' do
        category1 = FactoryGirl.create(:category, identifier: :red)
        category2 = FactoryGirl.create(:category, identifier: :yellow)
        FactoryGirl.create(:event, category: category2, starts: Setting.camp_start + 1.day)
        FactoryGirl.create(:event, category: category1, starts: Setting.camp_start + 1.day + 4.hours)

        Timecop.travel Setting.camp_start + 1.day + 2.hours
        get :catalog
        expect(assigns(:categories)).to eq([category1])
      end
    end

    describe "GET show" do
      let(:event) { FactoryGirl.create(:event) }

      it "assigns the requested event as @event" do
        get :show, {:id => event.to_param}
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "GET edit" do
      let(:event) { FactoryGirl.create(:event) }

      it "assigns the requested event as @event" do
        get :edit, {:id => event.to_param}
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "PUT update" do
      let(:event) { FactoryGirl.create(:event) }

      describe "with valid params" do
        it "updates the requested event" do
          expect_any_instance_of(Event).to receive(:update).with({ 'description' => 'this is a new text' })
          put :update, {:id => event.to_param, :event => { 'description' => 'this is a new text' }}
        end

        it "assigns the requested event as @event" do
          put :update, {:id => event.to_param, :event => { starts: Time.now + 2.hours } }
          expect(assigns(:event)).to eq(event)
        end

        it "redirects to the event" do
          put :update, {:id => event.to_param, :event => { starts: Time.now + 2.hours } }
          expect(response).to redirect_to(event)
        end
      end

      describe "with invalid params" do

        it "assigns the event as @event" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Event).to receive(:save).and_return(false)
          put :update, {:id => event.to_param, :event => { "owner" => "invalid value" }}
          expect(assigns(:event)).to eq(event)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Event).to receive(:save).and_return(false)
          put :update, {:id => event.to_param, :event => { "owner" => "invalid value" }}
          expect(response).to render_template("edit")
        end
      end
    end
  end
end
