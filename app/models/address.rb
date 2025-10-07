class Address < ApplicationRecord
  has_many :transactions, dependent: :destroy
  
  validates :address, presence: true, uniqueness: true
  # TODO: add validation for btc address format
  
  def transaction_count
    transactions.count
  end
  
  def update_balance!
    received = transactions.where(tx_type: 'received').sum(:amount)
    sent = transactions.where(tx_type: 'sent').sum(:amount)
    update!(balance: received - sent)
  end
end