require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      address = create(:address)
      expect(address).to be_valid
    end
    
    it 'requires an address' do
      address = build(:address, address: nil)
      expect(address).not_to be_valid
    end
    
    it 'requires unique address' do
      create(:address, address: 'test123')
      duplicate = build(:address, address: 'test123')
      expect(duplicate).not_to be_valid
    end
  end
  
  describe 'associations' do
    it 'has many transactions' do
      address = create(:address)
      create(:transaction, address: address)
      create(:transaction, address: address)
      
      expect(address.transactions.count).to eq(2)
    end
    
    it 'deletes transactions when address is deleted' do
      address = create(:address)
      create(:transaction, address: address)
      
      expect { address.destroy }.to change(Transaction, :count).by(-1)
    end
  end
  
  describe '#update_balance!' do
    it 'calculates correct balance' do
      address = create(:address)
      create(:transaction, address: address, tx_type: 'received', amount: 2.5)
      create(:transaction, address: address, tx_type: 'received', amount: 1.0)
      create(:transaction, address: address, tx_type: 'sent', amount: 0.8)
      
      address.update_balance!
      
      expect(address.balance).to eq(2.7)
    end
  end
end