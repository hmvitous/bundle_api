class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_error

  private

  def render_active_record_error(error)
    render json: {
      error_message: "We are experiencing internal errors. Please refresh the page and contact support. #{error.message}" 
    }, status: 400
  end
end