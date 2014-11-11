require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  context 'validations' do
    it 'validates that the email exists' do
      user = User.new
      user.valid?
      expect(user).to have(3).error_on(:email)
    end
  end

  describe '#fullname' do
    subject { user.fullname }
    specify { expect(subject).to eq("#{user.firstname} #{user.name}") }
  end

  describe "::import" do
    let(:file) { "test_import.csv" }
    let(:path) { Rails.root.join("spec/fixtures/#{file}") }
    let(:file_instance) { Rack::Test::UploadedFile.new(path, "text/csv") }

    context "every email address contains an @" do
      it "has more users than before" do
        expect {
          User.import(file_instance)
        }.to change { User.count }
      end

      it "does not add existing accounts" do
        expect {
          User.import(file_instance)
        }.to change { User.count }

        expect {
          User.import(file_instance)
        }.to_not change { User.count }
      end

      it 'generates the invitation_token for imported users' do
        FactoryGirl.create(:user)
        User.import(file_instance)
        expect(User.first.invitation_token).to be_nil
        expect(User.last.invitation_token).to_not be_nil
      end
    end

    context "email address does not contain an @" do
      let(:file) { "test_import_fail.csv" }

      it "does not have more users than before" do
        expect {
          User.import(file_instance)
        }.to_not change { User.count }
      end
    end
  end
end
