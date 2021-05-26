class DevicesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, device)
    ActionCable.server.broadcast 'devices_channel', { type: type, device: device }
  end
end
