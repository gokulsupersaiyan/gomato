require 'jb'
require_relative '../helpers/user_helper'

class ApplicationController < ActionController::API

  include ActionView::Rendering
  include UserHelper

  def render_model_errors(model)
    render json: { errors: model.errors }, status: :unprocessable_entity, handlers: 'json'
  end

  def render_not_authorized
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized, handlers: 'json'
  end

  def render_not_found
    render json: { errors: ['Object Not found'] }, status: :not_found, handlers: 'json'
  end

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    UserHelper.current_user_id = auth_token[:user_id]
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

end