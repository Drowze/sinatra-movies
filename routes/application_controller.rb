class ApplicationController < Sinatra::Base
  def json_params
    @json_params ||= JSON.parse(request.body.read, symbolize_names: true)
  end
end
