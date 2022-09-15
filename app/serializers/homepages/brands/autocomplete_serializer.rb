# frozen_string_literal: true

module Homepages::Brands
  class AutocompleteSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
