class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def session_user
    return nil unless params[:api_key]

    User.find_by(session: params[:api_key])
  end

  def token_user
    token = get_token
    return nil unless token

    token.user
  end

  def product_token_user(product_id, allow_nil: false)
    return nil if product_id.nil? && !allow_nil

    token = get_token
    return nil unless token
    return nil unless token.product&.id == product_id

    token.user
  end

  def require_session_or_token!
    json_error('permission denied', :unauthorized) unless session_user || token_user
  end

  def require_session_or_product_token!(product_id, allow_nil: false)
    unless session_user || product_token_user(product_id, allow_nil: allow_nil)
      json_error('permission denied', :unauthorized)
    end
  end

  def require_session!
    json_error('permission denied', :unauthorized) unless session_user
  end

  private

  def get_token
    return nil unless params[:api_key]

    token = Token.find_by(token: params[:api_key])
    return nil unless token
    return nil unless token.expires_at
    return nil if token.expires_at.to_time < Time.current

    token
  end
end
