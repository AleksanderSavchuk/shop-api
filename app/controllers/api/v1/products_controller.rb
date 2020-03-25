module Api
  module V1
    class ProductsController < ApplicationController
      before_action :authorize_request, except: %i[index show]

      def index
        @products = Product.all
        authorize @products, :index?
        @status = 'ok'
      end

      def show
        @product = Product.find(product_params[:id])
        authorize @product, :show?
        @status = 'ok'
      end

      def create
        @product = Product.new(product_params)
        authorize @product, :create?
        if @product.save
          @status = 'created'
        else
          render json: { errors: @product.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        @product = Product.find(product_params[:id])
        authorize @product, :update?
        if @product.update(product_params)
          @status = 'ok'
        else
          render json: { errors: @product.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @product = Product.find(product_params[:id])
        authorize @product, :destroy?
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
