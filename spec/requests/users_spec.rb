# frozen_string_literal: true

require 'swagger_helper'

describe 'Send users API' do
  let(:user) { create :user, :admin }
  let(:Authorization) { JsonWebToken.encode(user_id: user.id) }

  path '/api/v1/users', swagger_doc: SWAGGER_API_V1 do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email username password password_confirmation]
      }, required: true

      response '200', 'user created' do
        let(:params) do
          {
            name: 'test',
            username: 'username',
            email: 'email.email@email.com',
            password: 'password',
            password_confirmation: 'password'
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users', swagger_doc: SWAGGER_API_V1 do
    get 'Retrieve all users' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true

      response '200', 'users found' do
        schema(
          type: :object,
          properties: {
            users: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  username: { type: :string },
                  email: { type: :string }
                }
              }
            }
          },
          required: %w[users status]
        )
        let!(:users) { create_list :user, 4 }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}', swagger_doc: SWAGGER_API_V1 do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true
      parameter name: :id, in: :path, schema: { type: :integer }

      response '200', 'user found' do
        schema(
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            username: { type: :string },
            email: { type: :string }
          },
          required: ['user']
        )
        let(:user) { create :user, :client }
        let(:id) { user.id }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}', swagger_doc: SWAGGER_API_V1 do
    put 'Updates a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true
      parameter name: :id, in: :path, schema: { type: :integer }
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email username password password_confirmation]
      }, required: true

      response '200', 'user updated' do
        let(:id) { create(:user).id }
        let(:username) { 'new_username' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}', swagger_doc: SWAGGER_API_V1 do
    delete 'Deletes a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true
      parameter name: :id, in: :path, schema: { type: :integer }

      response '200', 'user deleted' do
        let(:id) { create(:user).id }
        run_test!
      end
    end
  end
end
