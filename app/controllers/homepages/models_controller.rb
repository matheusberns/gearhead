# frozen_string_literal: true

module Homepages
  class ModelsController < ActionController::API
    include ApplyFilters
    include Renders

    def autocomplete
      @models = Model.autocomplete

      @models = apply_filters(@models, :active_boolean, :by_search, :by_brand_type)

      render_index_success_json(body: @models, return_name: 'models')
    end
  end
end
