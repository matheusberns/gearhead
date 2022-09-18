# frozen_string_literal: true

module Homepages
  class BrandsController < ApplicationController

    def autocomplete
      @brands = Brand.autocomplete

      @brands = apply_filters(@brands, :active_boolean, :by_search)

      render_index_success_json(body: @brands, return_name: 'brands')
    end
  end
end
