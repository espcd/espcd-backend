class TokensBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, data)
    ActionCable.server.broadcast 'tokens_channel', { type: type, data: data }
  end
end
