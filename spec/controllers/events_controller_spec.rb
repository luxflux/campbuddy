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

    let(:valid_attributes) do
      FactoryGirl.attributes_for(:event).merge(owner_id: owner.id, category_id: category.id)
    end

    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all events as @events" do
        event = FactoryGirl.create(:event)
        get :index, {}, valid_session
        expect(assigns(:events)).to eq([event])
      end

      it 'assigns all the categories of the events as @categories' do
        category1 = FactoryGirl.create(:category, identifier: :red)
        category2 = FactoryGirl.create(:category, identifier: :yellow)
        FactoryGirl.create(:event, category: category2, starts: Time.current - 24.hours)
        FactoryGirl.create(:event, category: category1)

        get :index, {}, valid_session
        expect(assigns(:categories)).to eq([category1])
      end

      context 'without a date selected' do
        it 'assigns the current date as selection' do
          get :index, {}, valid_session
          expect(assigns(:selected_date)).to eq(Date.current)
        end
      end

      context 'with an invalid date selected' do
        it 'assigns the current date as selection' do
          get :index, { date: 'asd' }, valid_session
          expect(assigns(:selected_date)).to eq(Date.current)
        end
      end

      context 'with an valid date selected' do
        it 'assigns the current date as selection' do
          get :index, { date: '2014-04-01' }, valid_session
          expect(assigns(:selected_date)).to eq(Date.new(2014,4,1))
        end
      end
    end

    describe "GET show" do
      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        get :show, {:id => event.to_param}, valid_session
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "GET edit" do
      it "assigns the requested event as @event" do
        event = Event.create! valid_attributes
        get :edit, {:id => event.to_param}, valid_session
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested event" do
          event = Event.create! valid_attributes
          # Assuming there are no other events in the database, this
          # specifies that the Event created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          expect_any_instance_of(Event).to receive(:update).with({ 'owner_id' => owner.id.to_s })
          put :update, {:id => event.to_param, :event => { owner_id: owner.id }}, valid_session
        end

        it "assigns the requested event as @event" do
          event = Event.create! valid_attributes
          put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
          expect(assigns(:event)).to eq(event)
        end

        it "redirects to the event" do
          event = Event.create! valid_attributes
          put :update, {:id => event.to_param, :event => valid_attributes}, valid_session
          expect(response).to redirect_to(event)
        end
      end

      describe "with invalid params" do
        it "assigns the event as @event" do
          event = Event.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Event).to receive(:save).and_return(false)
          put :update, {:id => event.to_param, :event => { "owner" => "invalid value" }}, valid_session
          expect(assigns(:event)).to eq(event)
        end

        it "re-renders the 'edit' template" do
          event = Event.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Event).to receive(:save).and_return(false)
          put :update, {:id => event.to_param, :event => { "owner" => "invalid value" }}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  end
end
