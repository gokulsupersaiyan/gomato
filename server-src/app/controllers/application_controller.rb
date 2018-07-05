class ApplicationController < ActionController::API
  around_action :wrap_global_errors

  def wrap_global_errors
    yield
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Object Not found'] }, status: :internal_server_error
  rescue ActionController::ParameterMissing
    render json: { errors: ['Invalid request'] }, status: :internal_server_error
  rescue StandardError => error
    puts error.inspect
    render json: { errors: ['Unknown error occurred'] }, status: :internal_server_error
  rescue Exception => error
    puts error.inspect
  end

  def create_model(model)
    if model.save
      if block_given?
        render json: yield, status: :created, location: model
      else
        render json: { model.singular_name => model }, status: :created, location: model
      end
    else
      render json: { errors: model.errors }, status: :unprocessable_entity
    end
  end

  def update_model(model)
    if yield
      render json: { model.singular_name => model }, status: :ok, location: model
    else
      render json: { errors: model.errors }, status: :unprocessable_entity
    end
  end
end
