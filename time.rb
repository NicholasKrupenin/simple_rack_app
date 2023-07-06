class TimeApp
  AVAILABLE_FORMATS = { 'year' => '%Y', 'month' => '%B', 'day' => '%d',
                        'hour' => '%k', 'minute' => '%M', 'second' => '%S' }

  def call(env)
    request = Rack::Request.new(env)
    @params_format = request.params['format'].split(',')

    [ nice_format? ? '200' : '400', { 'Content-Type' => 'text/plain' }, [format] ]
  end

  private

  def nice_format?
    @params_format.all? { |format| AVAILABLE_FORMATS.key?(format) }
  end

  def format
    if nice_format?
      formatted_time = @params_format.map { |format| AVAILABLE_FORMATS[format] }.join('-')
      Time.now.strftime(formatted_time)
    else
       bad_form = @params_format.select { |format| !AVAILABLE_FORMATS.key?(format) }
       "Unknown time format [#{bad_form.join(', ')}]"
    end
  end
end
