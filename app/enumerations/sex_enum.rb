# frozen_string_literal: true

class SexEnum < EnumerateIt::Base
  associate_values(
    male: 1,
    female: 2
  )

  sort_by :value
end
