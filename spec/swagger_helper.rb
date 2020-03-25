require 'rails_helper'

SWAGGER_API_V1 = 'v1/swagger.yaml'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    SWAGGER_API_V1 => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      securityDefinitions: {
        JWT: {
          description: 'the jwt for API auth',
          type: :apiKey,
          name: 'Authorization',
          in: :header
        }
      }
    }
  }

  config.swagger_format = :yaml
end
