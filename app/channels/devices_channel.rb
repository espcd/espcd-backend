class DevicesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "devices_channel"
  end

  def unsubscribed
  end
end
