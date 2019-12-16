module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :find_user, except: %i[create index]

      def index
        @users = User.all
        @status = 'ok'
      end

      def show
        @user
        @status = 'ok'
      end

      def create
        @user = User.new(user_params)
        if @user.save
          @status = 'created'
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        return if @user.update(user_params)

        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end

      def destroy
        @user.destroy
        @status = 'destroyed'
      end

      private

      def find_user
        @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
      end

      def user_params
        params.permit(
          :avatar, :name, :username, :email, :password, :password_confirmation
        )
      end
    end
  end
end
