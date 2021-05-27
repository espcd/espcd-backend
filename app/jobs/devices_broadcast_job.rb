class DevicesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, data)
    ActionCable.server.broadcast 'devices_channel', { type: type, data: data }
  end
end
