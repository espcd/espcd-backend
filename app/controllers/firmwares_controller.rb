class FirmwaresController < ApplicationController
  before_action :set_firmware, only: [:show, :update, :destroy, :content]

  def index
    @firmwares = Firmware.all
    json_response(@firmwares)
  end

  def show
    json_response(@firmware)
  end

  def create
    @firmware = Firmware.create!(firmware_params)
    @firmware.product.update!(firmware: @firmware)
    ActionCable.server.broadcast 'firmwares_channel', { type: 'create', firmware: @firmware }
    json_response(@firmware, :created)
  end

  def update
    @firmware.update!(firmware_params)
    ActionCable.server.broadcast 'firmwares_channel', { type: 'update', firmware: @firmware }
    json_response(@firmware)
  end

  def destroy
    @firmware.destroy!
    ActionCable.server.broadcast 'firmwares_channel', { type: 'destroy', firmware: @firmware }
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
      .permit(:id, :version, :title, :description, :model, :content, :product_id)
  end

  def set_firmware
    @firmware = Firmware.find(params[:id])
  end
end
