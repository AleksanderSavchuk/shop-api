# frozen_string_literal: true

require 'swagger_helper'

describe 'Send products API' do
  let(:user) { create :user, :admin }
  let(:Authorization) { JsonWebToken.encode(user_id: user.id) }

  path '/api/v1/products', swagger_doc: SWAGGER_API_V1 do
    post 'Creates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: %w[name description]
      }, required: true

      response '200', 'product created' do
        let(:params) { build :product }
        run_test!
      end
    end
  end

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
          }
        )
        let!(:products) { create_list :product, 4 }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}', swagger_doc: SWAGGER_API_V1 do
    get 'Retrieves a product' do
      tags 'Products'
      produces 'application/json'
      parameter name: :id, in: :path, schema: { type: :integer }

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
        let(:id) { create(:product).id }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}', swagger_doc: SWAGGER_API_V1 do
    put 'Updates a product' do
      tags 'Products'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true
      parameter name: :id, in: :path, schema: { type: :integer }
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: %w[name description]
      }, required: true
      response '200', 'product updated' do
        let(:id) { create(:product).id }
        let(:description) { 'new desc' }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}', swagger_doc: SWAGGER_API_V1 do
    delete 'Deletes a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, schema: { type: :string }, required: true
      parameter name: :id, in: :path, schema: { type: :integer }

      response '200', 'product deleted' do
        let(:id) { create(:product).id }
        run_test!
      end
    end
  end
end
