require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: current_user.id
    end
  end

  describe '#current_user' do
    it 'assigns @current_user based on user_id param' do
      user = create(:user)
      get :index, params: { user_id: user.id }
      expect(assigns(:current_user)).to eq(user)
    end
  end
end