class FirmwaresController < ApplicationController
  before_action :set_firmware, except: [:index, :create]

  before_action :require_session!, only: [:index, :destroy]
  before_action only: [:create] do
    require_session_or_token!
  end
  before_action only: [:show, :update, :content] do
    board_type = BoardType.find_by(firmware_id: params[:id])
    require_session_or_product_token!(board_type&.product&.id)
  end
  before_action only: [:content] do
    board_type = BoardType.find_by(firmware_id: params[:id])
    json_error('auto update disabled', :bad_request) unless session_user || board_type&.product&.auto_update
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
        .permit(:id, :version, :title, :description, :fqbn, :content)
    else
      ActionController::Parameters.new
    end
  end

  def set_firmware
    @firmware = Firmware.find(params[:id])
  end
end
