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
      [422, { errors: user.errors }.to_json]
    end
  end

  patch '/:id' do
    return [404, { errors: ['entity not found'] }.to_json] if target_user.nil?
    return [422, { errors: ['malformed parameters'] }.to_json] if user_params.empty?
    target_user.values.merge!(user_params)

    if target_user.valid?
      target_user.save
      [200, target_user.values.to_json]
    else
      [422, { errors: target_user.errors.to_json }.to_json]
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
