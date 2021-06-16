class BoardTypesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'board_types_channel'
  end

  def unsubscribed
  end
end
