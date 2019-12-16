module Api
  module V1
    class ProductsController < ApplicationController
      def index
        @products = Product.all
        @status = 'ok'
      end

      def show
        @product = Product.find(product_params[:id])
        @status = 'ok'
      end

      def create
        @product = Product.new(product_params)
        if @product.save
          @status = 'created'
        else
          render json: { errors: @product.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        return if @product.update(product_params)

        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end

      def destroy
        @product.destroy
        @status = 'destroyed'
      end

      private

      def product_params
        params.permit(
          :name, :description, :id
        )
      end
    end
  end
end
