require_relative 'time'

ROUTES = {
  '/time' => TimeApp.new
}.freeze

use Rack::ContentType, "text/plain"
run Rack::URLMap.new(ROUTES)
