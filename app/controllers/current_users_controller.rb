# frozen_string_literal: true

class CurrentUsersController < ::ApiController
  include CheckCurrentPassword
  include PasswordChangeManageTokens
  before_action :validate_current_password, only: :update

  def show
    render_show_json(@current_user, Overrides::SessionSerializer, 'user')
  end

  def update
    if @current_user.update(user_update_params)
      manage_current_tokens
      render_show_json(@current_user, Overrides::SessionSerializer, 'user')
    else
      render_errors_json(@current_user.errors.messages)
    end
  end

  def images
    if @current_user.update(images_params)
      render_show_json(@current_user, Overrides::SessionSerializer, 'user')
    else
      render_errors_json(@current_user.errors.messages)
    end
  end

  def accept_use_term
    @use_term = @current_user.user_use_terms.find_by(use_term_id: params[:user][:use_term_id])
    if @use_term.update(accept: true)
      render_show_json(@current_user, Overrides::SessionSerializer, 'user')
    else
      render_errors_json(@current_user.errors.messages)
    end
  end

  private

  def images_params
    params
      .require(:user)
      .permit(:photo)
      .transform_values do |value|
      value == 'null' ? nil : value
    end
  end

  def user_update_params
    user_params.merge(updated_by_id: @current_user.id)
  end

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
              :password_confirmation,
              :force_modify_password)
  end
end