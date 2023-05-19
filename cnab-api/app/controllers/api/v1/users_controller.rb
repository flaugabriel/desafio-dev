class Api::V1::UsersController < ApiController
  def profile
    render json: { data: current_user }, status: :ok
  end

  def session
    json_error_response('Sessão inválida', :unauthorized) unless user_signed_in?

    render json: { message: 'Sessão válida.' }, status: :ok
  end
end