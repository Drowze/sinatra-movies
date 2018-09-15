class UsersController < ApplicationController
  get '/' do
    User.naked.all.to_json
  end

  post '/' do
    user = User.new(user_params)
    if user.valid?
      user.save
      [201, user.values.to_json]
    else
      [422, user.errors.to_json]
    end
  end

  patch '/:id' do
    target_user.values.merge!(user_params)

    if target_user.valid?
      target_user.save
      [200, target_user.values.to_json]
    else
      [422, target_user.errors.to_json]
    end
  end

  private

  def target_user
    @target_user ||= User.find(id: params[:id])
  end

  def user_params
    @user_params ||=
      json_params.fetch(:user, {})
                 .slice(:name, :age, :gender, :latitude, :longitude)
  end
end
