class Transaction < ApplicationRecord
  belongs_to :address
  
  validates :tx_hash, presence: true, uniqueness: { scope: :address_id }
  validates :amount, presence: true, numericality: true
  validates :tx_type, presence: true, inclusion: { in: ["received", "sent"] }
  validates :timestamp, presence: true
  
  scope :recent, -> { order(timestamp: :desc) }
end