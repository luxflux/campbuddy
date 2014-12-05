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
      it "assigns all events as @events" do
        event = FactoryGirl.create(:event)
        get :index, { date: event.starts }
        expect(assigns(:events)).to eq([event])
      end

      it 'assigns all the categories of the events as @categories' do
        category1 = FactoryGirl.create(:category, identifier: :red)
        category2 = FactoryGirl.create(:category, identifier: :yellow)
        FactoryGirl.create(:event, category: category2, starts: Time.current - 24.hours)
        event = FactoryGirl.create(:event, category: category1)

        get :index, { date: event.starts }
        expect(assigns(:categories)).to eq([category1])
      end

      context 'without a date selected' do
        it 'assigns the current date as selection' do
          get :index, {}
          expect(assigns(:selected_date)).to eq(Date.current)
        end
      end

      context 'with an invalid date selected' do
        it 'assigns the current date as selection' do
          get :index, { date: 'asd' }
          expect(assigns(:selected_date)).to eq(Date.current)
        end
      end

      context 'with an valid date selected' do
        it 'assigns the current date as selection' do
          get :index, { date: '2014-04-01' }
          expect(assigns(:selected_date)).to eq(Date.new(2014,4,1))
        end
      end
    end

    describe 'GET catalog' do
      it 'assigns all Events in the future as @events' do
        passed_event = FactoryGirl.create(:event, starts: Time.now + 1.hour)
        future_event = FactoryGirl.create(:event, starts: Time.now + 3.hours)
        Timecop.freeze Time.now + 2.hours
        get :catalog
        expect(assigns(:events)).to eq([future_event])
      end

      it 'does not fetch mandatory events' do
        mandatory_event = FactoryGirl.create(:event, mandatory: true)
        get :catalog
        expect(assigns(:events)).to eq([])
      end

      it 'does not fetch group events' do
        mandatory_event = FactoryGirl.create(:event, groups_only: true)
        get :catalog
        expect(assigns(:events)).to eq([])
      end

      it 'assigns all the categories of the events as @categories' do
        category1 = FactoryGirl.create(:category, identifier: :red)
        category2 = FactoryGirl.create(:category, identifier: :yellow)
        FactoryGirl.create(:event, category: category2, starts: Time.current - 24.hours)
        FactoryGirl.create(:event, category: category1, starts: Time.current + 4.hours)

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
