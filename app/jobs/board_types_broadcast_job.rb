class BoardTypesBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, data)
    ActionCable.server.broadcast 'board_types_channel', { type: type, data: data }
  end
end
