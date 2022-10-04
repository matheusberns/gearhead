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

  def password_recovery
    @user = User.by_cpf(params[:user][:cpf]).by_email(params[:user][:email])

    unless @user
      return render_errors_json('Usuário não encontrado')
    end

    if @user.password_recovery
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
