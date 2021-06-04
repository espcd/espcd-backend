class SessionsController < ApplicationController
  before_action :require_session!, except: [:create]

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session = user.session
      unless session
        session = SecureRandom.uuid
        user.update!(session: session)
      end
      json_response({ id: user.id, token: session }, :created)
    else
      json_error('Wrong credentials', :unauthorized)
    end
  end

  def destroy
    session_user&.update(session: nil)
  end
end
