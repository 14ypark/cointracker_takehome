require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      transaction = build(:transaction)
      expect(transaction).to be_valid
    end
    
    it 'requires tx_hash' do
      transaction = build(:transaction, tx_hash: nil)
      expect(transaction).not_to be_valid
    end
    
    it 'requires amount' do
      transaction = build(:transaction, amount: nil)
      expect(transaction).not_to be_valid
    end
    
    it 'requires tx_type to be received or sent' do
      transaction = build(:transaction, tx_type: 'invalid')
      expect(transaction).not_to be_valid
    end
    
    it 'allows received tx_type' do
      transaction = build(:transaction, tx_type: 'received')
      expect(transaction).to be_valid
    end
    
    it 'allows sent tx_type' do
      transaction = build(:transaction, tx_type: 'sent')
      expect(transaction).to be_valid
    end
  end
  
  describe 'associations' do
    it 'belongs to an address' do
      address = create(:address)
      transaction = create(:transaction, address: address)
      
      expect(transaction.address).to eq(address)
    end
  end
  
  describe 'scopes' do
    it 'orders by most recent first' do
      address = create(:address)
      old_tx = create(:transaction, address: address, timestamp: 2.days.ago)
      new_tx = create(:transaction, address: address, timestamp: 1.day.ago)
      
      expect(Transaction.recent.first).to eq(new_tx)
    end
  end
end