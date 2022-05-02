require 'swagger_helper'

RSpec.describe 'api/v1/auth', type: :request do

  path '/api/v1/auth/login' do

    post 'login authentication' do
      tags 'Authentication'
      consumes 'application/json'
      security [ ]
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }
      response(200, 'successful') do
        let(:create_user) { FactoryBot.create(:user) }
        let(:user) { { username: create_user.username, password: create_user.password } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:user) { { username: "Nouser", password: "No password" } }

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
