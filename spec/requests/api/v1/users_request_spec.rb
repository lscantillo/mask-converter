require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  let(:user_token) {FactoryBot.create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user_token.id) }
  let(:Authorization) { "Bearer #{token}" }

  path '/api/v1/users' do
    get('list users') do
      tags 'Users'
      response(200, 'successful') do

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

    post('create user') do
      tags 'Users'
      consumes 'application/json'
      security [bearerAuth: {}]
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[username password password_confirmation]
      }
      response(201, 'successful') do
        let(:user_info) { FactoryBot.build(:user) }
        let(:user) { { username: user_info.username, password: user_info.password, password_confirmation: user_info.password_confirmation } }
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

  # path '/api/v1/users/{id}' do
  #
  #   get('show user') do
  #     tags 'Users'
  #     consumes 'application/json'
  #     security [bearerAuth: {}]
  #     parameter name: 'id', in: :path, type: :string, description: 'id'
  #     response(200, 'successful') do
  #       let!(:user1) { FactoryBot.create(:user) }
  #       let(:id) { user_token.id }
  #       puts "user_token_id: #{id}"
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   patch('update user') do
  #     tags 'Users'
  #     consumes 'application/json'
  #     security [bearerAuth: {}]
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   put('update user') do
  #     tags 'Users'
  #     consumes 'application/json'
  #     security [bearerAuth: {}]
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   delete('delete user') do
  #     tags 'Users'
  #     consumes 'application/json'
  #     security [bearerAuth: {}]
  #     parameter name: 'id', in: :path, type: :string, description: 'id'
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end
