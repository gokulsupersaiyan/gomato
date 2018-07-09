require 'jb'

class ApplicationController < ActionController::API

  include ActionView::Rendering
  attr_reader :current_user


  around_action :wrap_global_errors

  def wrap_global_errors
    yield
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Object Not found'] }, status: :not_found
  rescue ActionController::ParameterMissing
    render json: { errors: ['Invalid request'] }, status: :bad_request
  rescue StandardError => error
    puts error.inspect
    render json: { errors: ['Unknown error occurred'] }, status: :internal_server_error
  rescue Exception => error
    puts error.inspect
  end


  def render_errors(model)
    render json: { errors: model.errors }, status: :unprocessable_entity
  end


  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

  def print_json_result(result, meta)
    render json: { result.table_name => result, meta: meta }, status: :ok
  end

  def current_user_id
    @current_user.id
  end

end