class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:sfdcid, :name, :close_date, :amount, :campaign_start_date, :vertical, :account, :agency, :advertiser, :stage_name, :opportunity_owner, :opp_type_new, :account_manager, :sales_region, :last_modified_date, :brand, :campaign_end_date, :campaign_objectives, :primary_audience_am, :secondary_audience_am, :hard_constraints_am, :is_secondary_audience_a_hard_constraint, :rfp_special_client_requests, :special_client_requirements, :special_notes, :brand_safety_vendor, :type_of_service, :brand_safety_restrictions, :who_is_paying_for_brand_safety, :client_vendor_pre_existing_relations, :who_will_implement_adchoices_icon, :brand_safety_notes, :who_will_wrap_the_tags, :io_case, :viewability, :viewability_metrics, :who_is_paying_for_viewability, :parent_order)
    end
end
