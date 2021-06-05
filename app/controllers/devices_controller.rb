class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]
  before_action :require_session_or_token!

  def index
    @devices = Device.all
    json_response(@devices)
  end

  def show
    @device.update('last_seen' => DateTime.now)

    json_response(@device)
  end

  def create
    @device = Device.create!(device_params)
    json_response(@device, :created)
  end

  def update
    @device.update!(device_params)
    json_response(@device)
  end

  def destroy
    @device.destroy!
    head :no_content
  end

  private

  def device_params
    params
      .require(:device)
      .permit(:id, :title, :description, :fqbn, :firmware_id, :last_seen, :product_id)
  end

  def set_device
    @device = Device.find(params[:id])
  end
end
