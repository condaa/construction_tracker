require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket, assigned_user: user) }

  describe 'GET #index' do
    it 'returns the current_user tickets in JSON format' do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      # Add more expectations as needed
    end
  end

  describe 'GET #show' do
    it 'returns the current_user ticket of the id param in JSON format' do
      get :show, params: { id: ticket.id, user_id: user.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      # Add more expectations as needed
    end
  end

  describe 'POST #create' do
    it 'creates a new ticket for the current_user' do
      post :create, params: { 
        ticket: { title: 'Amazing feature', status_id: Ticket.status_ids[:backlog] },
        user_id: user.id 
      }
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      # Add more expectations as needed
    end
  end

  describe 'PATCH #update' do
    it 'updates an existing ticket for the current_user' do
      patch :update, params: { id: ticket.id, ticket: { title: 'Updated Ticket' }, user_id: user.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      # Add more expectations as needed
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys an existing ticket for the current_user' do
      delete :destroy, params: { id: ticket.id, user_id: user.id }
      expect(response).to have_http_status(:no_content)
      # Add more expectations as needed
    end
  end
end