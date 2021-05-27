class FirmwaresBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, data)
    ActionCable.server.broadcast 'firmwares_channel', { type: type, data: data }
  end
end
