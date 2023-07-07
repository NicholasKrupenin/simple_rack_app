require_relative 'middleware/time_service'

class TimeApp
  def call(env)
    request = Rack::Request.new(env)
    if TimeService.new(request).bad_format.empty?
      send_response(TimeService.new(request).format, 200)
    else
      send_response("Unknown time format #{TimeService.new(request).bad_format}", 400)
    end
  end

  private

  def send_response(body, status)
    Rack::Response.new(body, status).finish
  end
end
