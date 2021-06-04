class TokensChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'tokens_channel'
  end

  def unsubscribed
  end
end
