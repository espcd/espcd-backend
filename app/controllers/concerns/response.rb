module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_error(message, status = 500)
    json_response({ message: message }, status)
  end
end
