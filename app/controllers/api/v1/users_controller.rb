module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create

      def index
        @users = User.all
        authorize @users, :index?
        @status = 'ok'
      end

      def show
        @user = User.find(user_params[:id])
        authorize @user, :show?
        @status = 'ok'
      end

      def create
        @user = User.create(user_params)
        authorize @user, :create?
        if @user.valid?
          @status = 'created'
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        @user = User.find(user_params[:id])
        authorize @user, :update?
        if @user.update(user_params)
          @status = 'updated'
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(user_params[:id])
        authorize @user, :destroy?
        @user.destroy
        @status = 'destroyed'
      end

      private

      def user_params
        params.permit(
          :id, :name, :username, :email, :password, :password_confirmation
        )
      end
    end
  end
end
