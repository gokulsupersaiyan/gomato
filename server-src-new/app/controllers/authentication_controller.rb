class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  def signup_user
    user = User.create(params.permit(:email, :password, :password_confirmation, :address))
    if user.errors.messages.empty?
      render json: { status: 'success' }, status: :ok
    else
      render_model_errors(user)
    end
  end

  private

  def payload(user)
    return nil unless user && user.id
    {
        auth_token: JsonWebToken.encode(user_id: user.id),
        user: { id: user.id, email: user.email }
    }
  end
end