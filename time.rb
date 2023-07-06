require_relative 'middleware/time_service'

class TimeApp
  def call(env)
    request = Rack::Request.new(env)
    if request.params['format']
      TimeService.new(request).form
    else
      [status, {}, body]
    end
  end

  private

  def status
    200
  end

  def body
    [Time.now.to_s]
  end
end
