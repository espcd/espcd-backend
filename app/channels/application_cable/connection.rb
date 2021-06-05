module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection unless cable_session_user
    end

    def cable_session_user
      return nil unless request.params[:api_key]

      User.find_by(session: request.params[:api_key])
    end
  end
end
