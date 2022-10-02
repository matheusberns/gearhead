# frozen_string_literal: true

module UserAccess
  extend ActiveSupport::Concern

  included do
    before_action :check_user_access
  end

  private

  def check_user_access
    render_unauthorized_access unless authorized_controller?
  end

  def authorized_controller?
    if @current_user.administrator?
      accessing_admin_controller?
    else
      accessing_user_controller?
    end
  end

  def accessing_admin_controller?
    admin_controller? || region_controller? || enumeration_controller?
  end

  def accessing_user_controller?
    user_controller?
  end

  def admin_controller?
    accessed_module == 'admins'
  end

  def user_controller?
    not_admin_controller?
  end

  def not_admin_controller?
    !admin_controller?
  end

  def region_controller?
    accessed_module == 'regions'
  end

  def enumeration_controller?
    accessed_module == 'enumerations'
  end

  def accessed_path
    params[:controller]
  end

  def accessed_action
    params[:action]
  end

  def accessed_module
    params[:controller].split('/').first
  end

  def render_unauthorized_access
    render_error_json nil, 403
  end
end
