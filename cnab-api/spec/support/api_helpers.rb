module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def login(current_user)
    post api_user_session_url, params: { email: current_user.email, password: current_user.password }
  end
end