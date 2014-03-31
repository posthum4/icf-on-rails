class CampaignOrdersController < ApplicationController
  before_action :set_campaign_order, only: [:show, :edit, :update, :destroy]

  # GET /campaign_orders
  # GET /campaign_orders.json
  def index
    @campaign_orders = CampaignOrder.all
  end

  # GET /campaign_orders/1
  # GET /campaign_orders/1.json
  def show
  end

  # GET /campaign_orders/new
  def new
    @campaign_order = CampaignOrder.new
  end

  # GET /campaign_orders/1/edit
  def edit
  end

  # POST /campaign_orders
  # POST /campaign_orders.json
  def create
    @campaign_order = CampaignOrder.new(campaign_order_params)

    respond_to do |format|
      if @campaign_order.save
        format.html { redirect_to @campaign_order, notice: 'Campaign order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campaign_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @campaign_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaign_orders/1
  # PATCH/PUT /campaign_orders/1.json
  def update
    respond_to do |format|
      if @campaign_order.update(campaign_order_params)
        format.html { redirect_to @campaign_order, notice: 'Campaign order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_orders/1
  # DELETE /campaign_orders/1.json
  def destroy
    @campaign_order.destroy
    respond_to do |format|
      format.html { redirect_to campaign_orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_order
      @campaign_order = CampaignOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_order_params
      params.require(:campaign_order).permit(:sfdcid, :name, :jira_key)
    end
end
