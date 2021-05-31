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
    @product.update!(product_params)
    json_response(@product)
  end

  def destroy
    @product.destroy!
    head :no_content
  end

  private

  def product_params
    if params[:product].present?
      params
        .require(:product)
        .permit(:id, :title, :description, :fqbn, :auto_update, :firmware_id)
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
