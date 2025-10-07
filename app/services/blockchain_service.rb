class BlockchainService
  include HTTParty
  base_uri 'https://blockchain.info'

  
  def self.fetch_address_data(btc_address)
    response = get("/rawaddr/#{btc_address}?limit=50")
    
    unless response.success?
      raise StandardError, "Blockchain API Error: #{response.code}"
    end
    
    response.parsed_response
  rescue HTTParty::Error, SocketError, Timeout::Error => e
    Rails.logger.error("BlockchainService Error: #{e.message}")
    raise StandardError, "Failed to fetch blockchain data: #{e.message}"
  end
end