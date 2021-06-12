class FirmwaresController < ApplicationController
  before_action :set_firmware, except: [:index, :create]

  before_action :require_session!, only: [:index, :destroy]
  before_action only: [:create] do
    require_session_or_token!(firmware_params[:product_id])
  end
  before_action only: [:show, :update, :content] do
    require_session_or_token!(@firmware.product.id)
  end

  def index
    @firmwares = Firmware.all
    json_response(@firmwares)
  end

  def show
    json_response(@firmware)
  end

  def create
    @firmware = Firmware.create!(firmware_params)
    remove_prodcuts_from_other
    json_response(@firmware, :created)
  end

  def update
    @firmware.update!(firmware_params)
    remove_prodcuts_from_other
    json_response(@firmware)
  end

  def destroy
    @firmware.destroy!
    head :no_content
  end

  def content
    if @firmware&.content&.attached?
      redirect_to rails_blob_url(@firmware.content)
    else
      head :not_found
    end
  end

  private

  def firmware_params
    params
      .require(:firmware)
      .permit(:id, :version, :title, :description, :fqbn, :content, :product_id)
  end

  def set_firmware
    @firmware = Firmware.find(params[:id])
  end

  def remove_prodcuts_from_other
    @firmware.product.firmwares.select { |f| f.fqbn == @firmware.fqbn && f.id != @firmware.id }.each do |firmware|
      firmware.update!(product_id: nil)
    end
  end
end
