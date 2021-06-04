class FirmwaresChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'firmwares_channel'
  end

  def unsubscribed
  end
end
