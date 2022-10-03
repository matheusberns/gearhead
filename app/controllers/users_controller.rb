# frozen_string_literal: true

class UsersController < ::ApiController
  include CheckCurrentPassword
  before_action :validate_current_password, only: :update

  def create
    @user = User.new(user_params)

    if @user.save
      render_show_json(@user, Users::ShowSerializer, 'user', 201)
    else
      render_errors_json(@user.errors.messages)
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name,
              :nickname,
              :email,
              :cpf,
              :birthday,
              :cellphone,
              :password,
              :password_confirmation)
  end
end
