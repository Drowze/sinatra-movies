class ApplicationController < Sinatra::Base
  def params_hash
    @params_hash ||= JSON.parse(request.body.read, symbolize_names: true)
  end
end
