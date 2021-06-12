class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :create]

  before_action :require_session!, only: [:index, :create, :destroy]
  before_action only: [:show, :update, :firmware] do
    require_session_or_token!(@product.id)
  end
  before_action only: [:firmware] do
    json_error('auto update disabled', :bad_request) unless @product.auto_update
  end

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

  def firmware
    firmwares = @product.firmwares.select { |f| f.fqbn == params[:fqbn] }
    firmware = firmwares.last
    json_response(firmware)
  end

  private

  def product_params
    params
      .require(:product)
      .permit(:id, :title, :description, :fqbn, :auto_update, :check_interval, :lock_firmwares)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
