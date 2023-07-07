class TimeService
  AVAILABLE_FORMATS = { 'year' => '%Y', 'month' => '%B', 'day' => '%d',
                        'hour' => '%k', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(request)
    @params_format = request.params['format'] ? request.params['format'].split(',') : ["empty_params"]
  end

  def format
    formatted_time = @params_format.map { |format| AVAILABLE_FORMATS[format] }.join('-')
    Time.now.strftime(formatted_time)
  end

  def bad_format
    @params_format.reject { |format| AVAILABLE_FORMATS.key?(format) }
  end
end
