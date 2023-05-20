class Api::V1::MyaccountController < ApiController

  def profile
    render json: { data: current_user }, status: :ok
  end

  def validate_session
    if user_signed_in?
      render json: { message: 'Session valid.' }, status: :ok
    else
      render json: { error: 'Sesion invalid.' }, status: :unauthorized
    end
  end
end