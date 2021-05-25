class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    json_response(@products)
  end

  def show
    json_response(@product)
  end

  def create
    @product = Product.create!(product_params)
    ActionCable.server.broadcast 'products_channel', { type: 'create', product: @product }
    json_response(@product, :created)
  end

  def update
    @product.update!(product_params)
    ActionCable.server.broadcast 'products_channel', { type: 'update', product: @product }
    json_response(@product)
  end

  def destroy
    @product.destroy!
    ActionCable.server.broadcast 'products_channel', { type: 'destroy', product: @product }
    head :no_content
  end

  private

  def product_params
    params
      .require(:product)
      .permit(:id, :title, :description, :model, :auto_update, :firmware_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
