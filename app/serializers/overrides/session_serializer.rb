# frozen_string_literal: true

module Overrides
  class SessionSerializer < BaseSerializer
    attributes :name,
                  :email,
                  :is_admin,
                  :birthday,
                  :cellphone,
                  :nickname,
                  :cpf,
                  :photo

    def birthday
      object.birthday&.to_time&.iso8601
    end

    def cpf
      ::CPF.new(object.cpf)&.formatted
    end

    def photo
      object.photo_dimensions
    end

    # def permissions
      # object.group_permissions.uniq.map do |group_permission|
      #   {
      #     id: group_permission.permission.id,
      #     name: group_permission.permission.name,
      #     module_type: { id: group_permission.permission.module_type, name: group_permission.permission.module_type_humanize },
      #     code: group_permission.permission.code
      #   }
      # end
    # end
  end
end
