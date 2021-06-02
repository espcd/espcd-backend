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
    token&.user
  end

  def require_session_or_token!
    raise 'permission denied' unless session_user || token_user
  end

  def require_session!
    raise 'permission denied' unless session_user
  end
end
