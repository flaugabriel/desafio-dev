require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #profile' do
    before do 
      get :profile
    end

    it 'when return the user profile' do

      binding.pry
      
      
      # expect(user).to be_valid

    end

    it 'when return the session' do

    end
  end

  describe 'GET #session' do
    context 'when profile is not avaliable' do
      it 'return erro no profile' do

      end
    end

    context 'when user have invalid session' do
      it 'return invalid session' do
        
      end
    end
  end
end