class UsersController < ApplicationController
  get '/' do
    User.naked.all.to_json
  end

  post '/' do
    user_params = params_hash.fetch(:user).slice(:name)
    user = User.new(user_params)
    if user.valid?
      user.save
      [201, user.values.to_json]
    else
      [422, user.errors.to_json]
    end
  end
end
