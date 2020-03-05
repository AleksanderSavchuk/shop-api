# frozen_string_literal: true

require 'swagger_helper'

describe 'Send products API' do
  # let!(:admin_user) { create :user, :admin_role }

  path '/api/v1/products', swagger_doc: SWAGGER_API_V1 do
    get 'Retrieve all products' do
      tags 'Products'
      produces 'application/json'
      response '200', 'products found' do
        schema(
          type: :object,
          properties: {
            products: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  description: { type: :string }
                }
              }
            }
          },
          required: %w[products status]
        )
        let!(:products) { create_list :product, 4 }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do
    get 'Retrieves a product' do
      tags 'Products'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'product found' do
        schema(
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string }
          },
          required: ['product']
        )
        let(:id) { Product.create(name: 'Test', description: 'test test').id }
        run_test!
      end
    end
  end

  path '/api/v1/products' do
    post 'Creates a blog' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: %w[name description]
      }

      response '200', 'product created' do
        let(:product) { build :product }
        run_test!
      end
    end
  end
end
