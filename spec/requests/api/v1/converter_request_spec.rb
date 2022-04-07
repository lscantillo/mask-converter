require 'rails_helper'

RSpec.describe "api/v1/converters", type: :request do

    path 'api/v1/converters/cidr_to_mask' do
      get 'Convert CIDR to mask' do
        tags 'Converters'
        consumes 'application/json'
        parameter name: :cidr, in: :query, type: :string, required: true, description: 'CIDR'
        response '200', 'CIDR converted to mask' do
          let(:cidr) { '13'}
          run_test!
        end
        it "returns http success" do
          get "/converter/cidr_to_mask"
          expect(response).to have_http_status(:success)
        end
      end
    end

    path 'api/v1/converters/mask_to_cidr' do
      get 'Convert Mask to Cidr' do
        tags 'Converters'
        consumes 'application/json'
        parameter name: :mask, in: :query, type: :string, required: true, description: 'Mask'
        response '200', 'Mask converted to CIDR' do
          let(:mask) { '255.255.0.0'}
          run_test!
        end
        it "returns http success" do
          get "/converter/mask_to_cidr"
          expect(response).to have_http_status(:success)
        end
      end
    end


end
