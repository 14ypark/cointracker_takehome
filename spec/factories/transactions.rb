FactoryBot.define do
  factory :transaction do
    association :address
    tx_hash { SecureRandom.hex(32) }
    block_height { rand(1..9999) }
    timestamp { rand(1..10).days.ago }
    amount { rand(-5_000.0..5_000.0).round(8) }
    tx_type { "received" }
    confirmations { 10 }
  end
end
