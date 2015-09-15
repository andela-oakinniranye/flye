require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'Valid User' do
    before do
      set_valid_omniauth
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    let(:current_user){ User.find(session[:user_id]) }

    scenario 'user can sign in' do
      expect(current_user).to be_valid
    end

    scenario 'user can visit profile page' do
      get :show
      expect(response.status).to be 200
    end
  end

  context 'Invalid User' do
    before do
      request.env["omniauth.auth"] = set_invalid_omniauth
    end

    let(:current_user){ User.find(session[:user_id]) }

    scenario 'user cannot visit profile page' do
      get :show

      expect(response.status).to be 302
      is_expected.to redirect_to root_path
    end
  end
end
