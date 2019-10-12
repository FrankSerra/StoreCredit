class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  skip_before_action :set_customer, only: :quickAdd

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # POST /customers/quickAdd
  def quickAdd
    if params[:customer_id] && params[:amount]
      @trans = Transaction.new
      @trans.customer_id = params[:customer_id]
      @trans.amount      = params[:amount].to_f
      @trans.note        = "Quick add"
      @trans.stamp       = Time.now

      if @trans.save
        @trans.customer.lastmodified = @trans.stamp
        if @trans.customer.balance
          @trans.customer.balance = @trans.customer.balance + @trans.amount
        else
          @trans.customer.balance = @trans.amount
        end
        @trans.customer.save
      end

      redirect_to customers_url, notice: '$'+ ( '%.2f' % @trans.amount) + " applied to " + @trans.customer.name + "."
    end
  end

  # GET /customers/export
  def export
    csv_data = CSV.generate do |csv|
      csv << ["Name", "Balance", "Notes", "Last Modified"]
      url_items = Customer.all
      url_items.each do |url_item|
        csv << [url_item.name, url_item.balance, url_item.notes, url_item.localtimestring]
      end
    end

    fname = "customers_#{DateTime.now.to_i}.csv"
    send_data csv_data,
      :type => 'text/csv; charset=utf-8; header=present',
      :disposition => "attachment; filename=#{fname}.csv"
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.lastmodified = Time.now

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @customer.lastmodified = Time.now

    if customer_params.key?("tourentries") or customer_params.key?("tourpacks")
      hash = "payouts"
    else
      hash = "adjust"
    end

    puts "+++++++++"
    puts hash
    puts "+++++++++"

    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_path(@customer, anchor: hash), notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :balance, :lastmodified, :notes, :tourentries, :tourpacks)
    end
end
