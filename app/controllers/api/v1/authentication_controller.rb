module Api
  module V1
    class AuthenticationController < ApplicationController
      # before_action :authorize_request, except: :login

      def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          @token = JsonWebToken.encode(user_id: @user.id)
          @time = Time.now + 24.hours.to_i
          @status = 'ok'
        else
          @message = 'unauthorized'
          render 'error', status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
