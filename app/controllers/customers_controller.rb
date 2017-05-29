class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy, :get_customer_orders]

  # GET /customers
  def index
    @customers = Customer.all

    render json: @customers
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def get_customer_category_count
    # customer id | customer first name | category id | category name | number_purchased
    customer = Customer.find params[:customer_id]
    category = Category.find params[:category_id]
    category_count = Customer.category_count params

    @customer_category_count = {
      customer_id: customer.id,
      customer_first_name: customer.name,
      category_id: category.id,
      category_name: category.name,
      number_purchased: category_count
    }

    render json: @customer_category_count
  end

  def get_customer_orders
    @orders = @customer.orders

    render json: @orders
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      params[:customer_id] ? @customer = Customer.find(params[:customer_id]) : @customer = Customer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:name)
    end
end
