# frozen_string_literal: true

class UsersController < ::ApiController
  include CheckCurrentPassword
  include PasswordChangeManageTokens
  before_action :validate_permission, except: %i[:autocomplete :create]
  before_action :validate_current_password, only: :update
  before_action :set_user, only: %i[show update destroy images]

  def index
    @users = User.list

    @users = apply_filters(@users, :active_boolean,
                           :by_name,
                           :by_email,
                           :by_cpf)

    render_index_json(@users, Users::IndexSerializer, 'users')
  end

  def autocomplete
    @users = User.autocomplete

    @users = apply_filters(@users, :active_boolean, :by_search)

    render_index_json(@users, Users::AutocompleteSerializer, 'users')
  end

  def show
    render_show_json(@user, Users::ShowSerializer, 'user')
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      render_show_json(@user, Users::ShowSerializer, 'user', 201)
    else
      render_errors_json(@user.errors.messages)
    end
  end

  def update
    if @user.update(user_update_params)
      manage_current_tokens
      render_show_json(@user, Users::ShowSerializer, 'user')
    else
      render_errors_json(@user.errors.messages)
    end
  end

  def destroy
    verify_if_is_current_user_being_destroyed
    if @user.destroy
      render_success_json
    else
      render_errors_json(@user.errors.messages)
    end
  end

  def recover
    @user = User.list.active(false).find(params[:id])

    if @user.recover
      render_show_json(@user, Users::ShowSerializer, 'user')
    else
      render_errors_json(@user.errors.messages)
    end
  end

  def images
    if @user.update(images_params)
      render_show_json(@user, Users::ShowSerializer, 'user')
    else
      render_errors_json(@user.errors.messages)
    end
  end

  def update_company_time
    @update_company_time = ::Import::CompanyTime.new(params[:file], @account)
    @update_company_time.update_company_time

    if @update_company_time.errors.any?
      render_errors_json(@update_company_time.errors.messages)
    else
      render_success_json
    end
  end

  private

  def validate_permission
    render_error_json(status: 405) unless find_permission([::PermissionCodeEnum::USER_MANAGE])
  end

  def verify_if_is_current_user_being_destroyed
    @user.errors.add(:base, :current_user_being_destroyed) if @current_user.id == @user.id
  end

  def set_user
    @user = User.activated.list.find(params[:id])
  end

  def user_create_params
    user_params.merge(created_by_id: @current_user.id)
  end

  def user_update_params
    user_params.merge(updated_by_id: @current_user.id)
  end

  def images_params
    params
      .require(:user)
      .permit(:photo)
      .transform_values do |value|
      value == 'null' ? nil : value
    end
  end

  def user_params
    params
      .require(:user)
      .permit(:name,
              :email,
              :cpf,
              :birthday,
              :phone,
              :cellphone,
              :password,
              :password_confirmation)
  end
end
