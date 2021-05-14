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
    json_response(@product, :created)
  end

  def update
    @product.update(product_params)
    head :no_content
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params
      .require(:product)
      .permit(:id, :title, :description, :auto_update)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
