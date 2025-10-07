module Api
  class AddressesController < BaseController
    before_action :set_address, only: [:show, :destroy, :sync, :transactions]
    
    # GET /api/addresses
    def index
      addresses = Address.all
      render json: addresses.map { |addr| address_json(addr) }
    end
    
    # GET /api/addresses/:id
    def show
      render json: address_json(@address)
    end
    
    # POST /api/addresses
    def create
      address = Address.create!(address_params)
      render json: address_json(address), status: :created
    end
    
    # DELETE /api/addresses/:id
    def destroy
      @address.destroy
      head :no_content
    end
    
    # POST /api/addresses/:id/sync
    def sync
      service = AddressSyncService.new(@address)
      transactions_saved = service.sync
      
      render json: {
        message: "Sync completed",
        address: address_json(@address),
        transactions_saved: transactions_saved
      }
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
    
    # GET /api/addresses/:id/transactions
    def transactions
      page = params[:page]&.to_i || 1
      per_page = params[:limit]&.to_i || 50
      offset = (page - 1) * per_page
      
      txs = @address.transactions.recent.limit(per_page).offset(offset)
      
      render json: {
        address: @address.address,
        total: @address.transactions.count,
        transactions: txs.map { |tx| transaction_json(tx) }
      }
    end
    
    private
    
    def set_address
      @address = Address.find(params[:id])
    end
    
    def address_params
      params.require(:address).permit(:address, :label)
    end
    
    def address_json(address)
      {
        id: address.id,
        address: address.address,
        label: address.label,
        balance: address.balance&.to_s,
        last_synced: address.last_synced,
        transaction_count: address.transaction_count,
        created_at: address.created_at
      }
    end
    
    def transaction_json(transaction)
      {
        id: transaction.id,
        tx_hash: transaction.tx_hash,
        timestamp: transaction.timestamp,
        amount: transaction.amount.to_s,
        tx_type: transaction.tx_type,
        confirmations: transaction.confirmations
      }
    end
  end
end