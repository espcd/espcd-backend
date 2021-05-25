class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]

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
    ActionCable.server.broadcast 'devices_channel', { type: 'create', device: @device }
    json_response(@device, :created)
  end

  def update
    @device.update!(device_params)
    ActionCable.server.broadcast 'devices_channel', { type: 'update', device: @device }
    json_response(@device)
  end

  def destroy
    @device.destroy!
    ActionCable.server.broadcast 'devices_channel', { type: 'destroy', device: @device }
    head :no_content
  end

  private

  def device_params
    if params[:device].present?
      params
        .require(:device)
        .permit(:id, :title, :description, :model, :firmware_id, :last_seen, :product_id)
    end
  end

  def set_device
    @device = Device.find(params[:id])
  end
end
