class UsersController < ApplicationController
  get '/' do
    User.naked.all.to_json
  end
end
