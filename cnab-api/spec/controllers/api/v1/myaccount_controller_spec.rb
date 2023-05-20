require 'rails_helper'
include ActionController::RespondWith

RSpec.describe Api::V1::MyaccountController, type: :controller do
  let(:current_user) { create(:user) }

  describe 'GET #profile' do
    context "when return the current_user profile" do
      before do 
        sign_in current_user
      end

      it 'when return the user profile' do
          binding.pry
          # expect(user).to be_valid
      end

      it 'when return the session' do

      end
    end
  end

  def login(current_user)
    post '/api/auth/sign_in', params: { email: current_user.email, password: current_user.password }
  end
end