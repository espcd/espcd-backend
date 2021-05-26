class ProductsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(type, product)
    ActionCable.server.broadcast 'products_channel', { type: type, product: product }
  end
end
