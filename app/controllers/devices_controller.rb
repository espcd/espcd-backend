class DevicesController < ApplicationController
  before_action :set_device, except: [:index, :create]

  before_action :require_session!, only: [:index, :destroy]
  before_action only: [:create] do
    require_session_or_product_token!(device_params[:product_id], allow_nil: true)
  end
  before_action only: [:show, :update] do
    require_session_or_product_token!(@device.product&.id, allow_nil: true)
  end

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
    if params[:device].present?
      params
        .require(:device)
        .permit(:id, :title, :description, :fqbn, :firmware_id, :last_seen, :product_id)
    else
      ActionController::Parameters.new
    end
  end

  def set_device
    @device = Device.find(params[:id])
  end
end
