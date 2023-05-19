# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false
  config.token_cost = Rails.env.test? ? 4 : 10
  config.check_current_password_before_update = :password
  config.send_confirmation_email = false
  config.default_confirm_success_url = 'http://localhost:3000/login'
  config.default_password_reset_url =  'http://localhost:3000/reset-password'
  config.remove_tokens_after_password_reset = true
end