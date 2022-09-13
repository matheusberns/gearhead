# frozen_string_literal: true

module Concerns::ValidateUserPermissions
  extend ActiveSupport::Concern

  included do
    def check_user_without_permission(permission_codes: nil, to_allow: false)
      user = ::User.includes(:permissions).find_by(id: @current_user&.id)

      return unless user && permission_codes

      permission_codes = [permission_codes] unless permission_codes.is_a? Array

      user_permissions = user.permissions.pluck(:code)

      return if permission_codes.any? { |code| user_permissions&.include? code } || user.is_admin || to_allow

      render json: { error: 'Você não possui autorização', meta: Time.now.to_i }, status: 401
      true
    end
  end
end
