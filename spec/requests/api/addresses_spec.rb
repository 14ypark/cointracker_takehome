require 'rails_helper'

RSpec.describe 'Api::Addresses', type: :request do
  describe 'GET /api/addresses' do
    it 'returns all addresses' do
      address1 = create(:address)
      address2 = create(:address, address: '123123', label: 'abcabc')
      
      get '/api/addresses'
      
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end
  end
  
  describe 'GET /api/addresses/:id' do
    it 'returns a single address' do
      address = create(:address)
      
      get "/api/addresses/#{address.id}"
      
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['address']).to eq(address.address)
    end
    
    it 'returns 404 for non-existent address' do
      get '/api/addresses/11111111'
      
      expect(response).to have_http_status(:not_found)
    end
  end
  
  describe 'POST /api/addresses' do
    context 'with valid params' do
      let(:valid_params) do
        { address: { address: 'abcd12345', label: 'abcabc' } }
      end
      
      it 'creates a new address' do
        expect {
          post '/api/addresses', params: valid_params
        }.to change(Address, :count).by(1)
        
        expect(response).to have_http_status(:created)
      end
    end
    
    context 'with invalid params' do
      let(:invalid_params) do
        { address: { address: '', label: '11111111111' } }
      end
      
      it 'returns error' do
        post '/api/addresses', params: invalid_params
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe 'DELETE /api/addresses/:id' do
    it 'deletes the address' do
      address = create(:address)
      
      expect {
        delete "/api/addresses/#{address.id}"
      }.to change(Address, :count).by(-1)
      
      expect(response).to have_http_status(:no_content)
    end
  end
  
  describe 'GET /api/addresses/:id/transactions' do
    it 'returns transactions for address' do
      address = create(:address)
      create_list(:transaction, 3, address: address)
      
      get "/api/addresses/#{address.id}/transactions"
      
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['total']).to eq(3)
      expect(json['transactions'].length).to eq(3)
    end
  end
end