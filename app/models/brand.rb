# frozen_string_literal: true

class Brand < ApplicationRecord
  # Concerns

  # Active storage

  # Enumerations

  # Belongs associations

  # Has_many associations
  # has_many :posts, class_name: '::Post', inverse_of: :brand, foreign_key: :brand_id

  # Many-to-many associations

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .traceability
  }
  scope :autocomplete, lambda {
    select(:id, :name)
  }
  scope :by_search, ->(search) { by_name(search) }
  scope :by_name, lambda { |name|
    where("UNACCENT(#{table_name}.name) ILIKE :name",
          name: "%#{I18n.transliterate(name)}%")
  }

  # Callbacks

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
end
