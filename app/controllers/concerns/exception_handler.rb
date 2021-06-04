module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |e|
      json_error(e.message)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_error(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_error(e.message, :unprocessable_entity)
    end
  end
end
