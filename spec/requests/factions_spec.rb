require 'rails_helper'

RSpec.describe "Factions", type: :request do
  describe "GET /factions" do
    it "works! (now write some real specs)" do
      get factions_path
      expect(response).to have_http_status(200)
    end
  end
end
