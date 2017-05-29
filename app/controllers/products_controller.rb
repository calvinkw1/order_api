class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET categories/:category_id/products
  def index
    if params[:category_id]
      @products = Product.where(category_id: params[:category_id])
    else
      @products = Product.all
    end
    
    render json: @products
  end

  # GET /products/sold_by_date/:start_date/:end_date/:range
  def get_products_sold_breakdown
    @products_breakdown = Product.get_breakdown(params)
    render json: @products_breakdown
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :price, :category_id)
    end
end
