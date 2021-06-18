class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :create]
  before_action :set_board_type, only: [:firmware, :set_firmware]

  before_action :require_session!, only: [:index, :create, :destroy]
  before_action only: [:show, :update, :firmware] do
    require_session_or_product_token!(@product.id)
  end
  before_action only: [:firmware] do
    json_response(nil) unless @product.auto_update
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
    firmware = @board_type&.firmware
    json_response(firmware)
  end

  def set_firmware
    if @product.lock_firmwares
      return json_response(nil)
    end

    if @board_type
      @board_type.update!(firmware_id: params[:firmware_id])
    else
      @board_type = BoardType.create!(fqbn: params[:fqbn], product_id: params[:id], firmware_id: params[:firmware_id])
    end
    json_response(@board_type.firmware)
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

  def set_board_type
    @board_type = @product.board_types.select { |b| b.fqbn == params[:fqbn] }.last
  end
end
