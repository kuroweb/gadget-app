require 'rails_helper'

RSpec.describe "V1::Tags", type: :request do

  describe "GET /search" do
    it "returns http success" do
      get "/v1/tags/search"
      expect(response).to have_http_status(:success)
    end
  end

end
