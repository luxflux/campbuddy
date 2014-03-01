require 'spec_helper'

describe "Attendances" do
  describe "GET /attendances" do
    it "works! (now write some real specs)" do
      get attendances_path
      expect(response.status).to be(200)
    end
  end
end
