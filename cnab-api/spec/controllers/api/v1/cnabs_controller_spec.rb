require 'rails_helper'
include ActionController::RespondWith

RSpec.describe Api::V1::CnabsController, type: :request do
  let(:cnab) { create(:cnab) }
  let(:cnabs) { create_list(:cnab, 50, user: cnab.user) }

   describe 'GET #index' do
    context 'when return list of cnabs based by current user' do
      before do 
        login(cnabs.first.user)
      end

      it 'gives you a status 200' do
        @auth_params =  get_auth_params_from_login_response_headers(response)
        get api_cnabs_path ,headers: @auth_params
        expect(response.status).to eq(200)
      end

      it 'when return a list of 51 registers' do
        @auth_params =  get_auth_params_from_login_response_headers(response)
        get api_cnabs_path ,headers: @auth_params
        expect(response.status).to eq(200)
        
        binding.pry
        
        expect(json.length).to eq(51)
      end
    end
  end

  # describe 'GET #import' do   
  #   context 'when update account whit correct params' do     
  #     before do 
  #       login(current_user)
  #     end

  #     it 'gives you a status 200 on update' do

  #       user_params = { user: { 
  #         email: "falugabriel@gmail.com", 
  #         password: "321654987", 
  #         password_confirmation: "321654987" } 
  #       }

  #       api_my_account_profile_update_path(user_params)
  #       expect(response.status).to eq(200)
  #     end

  #     it 'when return error some password is wrong' do
  #       user_params = { user: { 
  #         email: "falugabriel@gmail.com", 
  #         password: "1", 
  #         password_confirmation: "654" } 
  #       }
  #       put api_my_account_profile_update_path(user_params)
  #       user = JSON.parse(response.body)

  #       expect(response.status).to eq(401)
  #       expect(user['errors'].present?).to eq(true)
  #     end
  #   end
  # end

  describe 'GET #delete_all' do   
    context 'when all cnabs of current user is deleted' do     
      before do 
        login(cnab.user)
      end

      it 'gives you a status 200' do
        @auth_params =  get_auth_params_from_login_response_headers(response)
        delete api_cnabs_path, headers: @auth_params
        expect(response.status).to eq(200)
      end

      it 'gives you a 1 number of list of cnabs' do
        @auth_params =  get_auth_params_from_login_response_headers(response)
        delete api_cnabs_path, headers: @auth_params
        expect(json.length).to eq(1)
      end
    end
  end

  def login(current_user)
    post '/api/auth/sign_in', params: { email: current_user.email, password: current_user.password }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end
end