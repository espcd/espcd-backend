class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def session_user
    return nil unless params[:api_key]

    User.find_by(session: params[:api_key])
  end

  def token_user
    return nil unless params[:api_key]

    token = Token.find_by(token: params[:api_key])
    return nil unless token&.expires_at
    return nil if token.expires_at.to_time < Time.current

    token.user
  end

  def require_session_or_token!
    json_error('permission denied', :unauthorized) unless session_user || token_user
  end

  def require_session!
    json_error('permission denied', :unauthorized) unless session_user
  end
end
