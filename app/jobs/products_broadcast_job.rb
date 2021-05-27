class ProductsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, data)
    ActionCable.server.broadcast 'products_channel', { type: type, data: data }
  end
end
