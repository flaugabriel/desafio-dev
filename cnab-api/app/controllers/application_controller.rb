# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  serialization_scope :current_user

  before_action :configure_permitted_parameters, if: :devise_controller?

  def json_error_response(messenger, status)
    render json: { messenger:, status: }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email password])
  end
end
