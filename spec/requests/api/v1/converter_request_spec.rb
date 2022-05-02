require 'swagger_helper'

RSpec.describe "api/v1/converters", type: :request do
  let(:user) {FactoryBot.create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:Authorization) { "Bearer #{token}" }

  path '/api/v1/converter/cidr_to_mask' do

    post 'Convert CIDR to mask' do
      tags 'Converters'
      consumes 'application/json'
      security [bearerAuth: {}]
      parameter name: :cidr, in: :body, schema: {
        type: :object,
        properties: {
          cidr: { type: :string }
        },
        required: %w[cidr]
      }

      response '200', 'CIDR converted to mask' do
        let(:cidr) { { cidr: '13' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!

      end

      response '401', 'Unauthorized' do
        let(:Authorization) { 'Bearer invalid' }
        let(:cidr) { { mask: 'geteh' } }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:cidr) { { cidr: 'dgegrger' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/converter/mask_to_cidr' do
    post 'Convert Mask to Cidr' do
      tags 'Converters'
      consumes 'application/json'
      security [bearerAuth: {}]
      parameter name: :mask, in: :body, schema: {
        type: :object,
        properties: {
          mask: { type: :string }
        },
        required: %w[mask]
      }

      response '200', 'Mask converted to CIDR' do
        let(:mask) { { mask: '255.255.0.0' } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { 'Bearer invalid' }
        let(:mask) { { mask: 'geteh' } }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:mask) { { mask: 'geteh' } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

    end
  end

end
