class FirmwaresBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, firmware)
    ActionCable.server.broadcast 'firmwares_channel', { type: type, firmware: firmware }
  end
end
