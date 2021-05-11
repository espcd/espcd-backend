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
    json_response(@firmware, :created)
  end

  def update
    @firmware.update(firmware_params)
    head :no_content
  end

  def destroy
    @firmware.destroy
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
      .permit(:id, :version, :title, :description, :content)
  end

  def set_firmware
    @firmware = Firmware.find(params[:id])
  end
end
