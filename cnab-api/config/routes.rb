require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get '/myaccount/validate_session', to: 'myaccount#validate_session'
      get '/myaccount/profile', to: 'myaccount#profile'
    end

    # for another features
    scope module: :v2, 
      constraints: ApiConstraints.new(version: 2, default: false) do 
    end
  end
end