require 'spec_helper'

describe User do

  context 'validations' do

    it 'should validate that the email exists' do
      user = User.new
      user.valid?
      expect(user).to have(1).error_on(:email)
    end

  end
end
