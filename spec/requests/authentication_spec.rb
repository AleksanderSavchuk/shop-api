# frozen_string_literal: true

require 'swagger_helper'

describe 'Send auth API' do
  path '/api/v1/auth/login', swagger_doc: SWAGGER_API_V1 do
    post 'Creates session' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }, required: true

      let(:test_email) { 'test@test.com' }
      let(:test_password) { 'password' }
      before do
        User.create(email: test_email,
                    password: test_password,
                    username: 'test',
                    password_confirmation: test_password)
      end

      response '200', 'user signed in' do
        let(:params) { { email: test_email, password: test_password } }
        run_test!
      end

      response '401', 'user unauthorized' do
        let(:params) { { email: 'pops', password: test_password } }
        run_test!
      end
    end
  end
end
