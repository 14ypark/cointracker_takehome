class BlockchainService
  include HTTParty
  base_uri 'https://api.blockchair.com'
  
  def self.fetch_address_data(btc_address)
    response = get("/bitcoin/dashboards/address/#{btc_address}")
    
    unless response.success?
      raise StandardError, "Blockchair API Error: #{response.code} - #{response.message}"
    end
    
    data = response.parsed_response['data'][btc_address]
    raise StandardError, "Address not found" unless data
    
    data
  rescue HTTParty::Error, SocketError, Timeout::Error => e
    Rails.logger.error("BlockchainService Error: #{e.message}")
    raise StandardError, "Failed to fetch blockchain data: #{e.message}"
  end
end