require 'rails_helper'

RSpec.describe "Converters", type: :request do

  describe "GET /cidr_to_mask" do
    it "returns http success" do
      get "/converter/cidr_to_mask"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mask_to_cidr" do
    it "returns http success" do
      get "/converter/mask_to_cidr"
      expect(response).to have_http_status(:success)
    end
  end

end
