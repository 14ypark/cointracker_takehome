class AddressSyncService
  def initialize(address)
    @address = address
  end
  
  def sync
    data = BlockchainService.fetch_address_data(@address.address)
    
    transactions_saved = save_transactions(data)
    
    @address.update_balance!
    @address.update!(last_synced: Time.current)
    
    transactions_saved
  end
  
  private
  
  def save_transactions(data)
    count = 0
    transactions = data['transactions'] || []
    
    transactions.each do |tx_data|
      save_transaction(tx_data)
      count += 1
    end
    
    count
  end
  
  def save_transaction(tx_data)
    received_amount = find_amount_in_outputs(tx_data)
    
    sent_amount = find_amount_in_inputs(tx_data)
    
    if received_amount > 0
      amount = received_amount
      tx_type = 'received'
    elsif sent_amount > 0
      amount = sent_amount
      tx_type = 'sent'
    else
      return 
    end
    
    @address.transactions.find_or_create_by!(tx_hash: tx_data['hash']) do |tx|
      tx.timestamp = Time.at(tx_data['time'])
      tx.amount = amount / 100_000_000.0  # Convert satoshis to BTC
      tx.tx_type = tx_type
      tx.block_height = tx_data['block_id']
      tx.confirmations = 10
    end
  end
  
  def find_amount_in_outputs(tx_data)
    outputs = tx_data['outputs'] || []
    outputs
      .select { |output| output['recipient'] == @address.address }
      .sum { |output| output['value'] || 0 }
  end
  
  def find_amount_in_inputs(tx_data)
    inputs = tx_data['inputs'] || []
    inputs
      .select { |input| input['recipient'] == @address.address }
      .sum { |input| input['value'] || 0 }
  end
end