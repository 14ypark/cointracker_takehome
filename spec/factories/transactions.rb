FactoryBot.define do
  factory :transaction do
    address { nil }
    tx_hash { "MyString" }
    block_height { 1 }
    timestamp { "2025-10-07 13:30:25" }
    amount { "9.99" }
    tx_type { "MyString" }
    confirmations { 1 }
  end
end
