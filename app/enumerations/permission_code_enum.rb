# frozen_string_literal: true

class PermissionCodeEnum < EnumerateIt::Base
  associate_values(
    brand_manage: 1
  )

  sort_by :value
end
