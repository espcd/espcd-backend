class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]

  def index
    @devices = Device.all
    json_response(@devices)
  end

  def show
    json_response(@device)
  end

  def create
    @device = Device.create!(device_params)
    json_response(@device, :created)
  end

  def update
    @device.update(device_params)
    head :no_content
  end

  def destroy
    @device.destroy
    head :no_content
  end

  private

  def device_params
    params.permit(:id, :title, :description, :model, :chip_id, :last_seen)
  end

  def set_device
    @device = Device.find(params[:id])
  end
end
