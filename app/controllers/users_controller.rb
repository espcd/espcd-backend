class UsersController < ApplicationController
  before_action :require_session!

  def show
    json_response({ id: session_user.id, username: session_user.username })
  end

  def update
    session_user.update!(password: params[:password])
    show
  end
end
