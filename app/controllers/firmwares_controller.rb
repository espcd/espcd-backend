class FirmwaresController < ApplicationController
  before_action :set_firmware, only: [:show, :update, :destroy, :content]
  before_action :require_session_or_token!

  def index
    @firmwares = Firmware.all
    json_response(@firmwares)
  end

  def show
    json_response(@firmware)
  end

  def create
    @firmware = Firmware.create!(firmware_params)
    @firmware.product&.update!(firmware: @firmware)
    json_response(@firmware, :created)
  end

  def update
    @firmware.update!(firmware_params)
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
    if params[:firmware].present?
      params
        .require(:firmware)
        .permit(:id, :version, :title, :description, :fqbn, :content, :product_id)
    end
  end

  def set_firmware
    @firmware = Firmware.find(params[:id])
  end
end
