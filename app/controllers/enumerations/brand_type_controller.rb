# frozen_string_literal: true

module Enumerations
  class BrandTypeController < ApplicationController
    before_action :set_object, only: :show

    def index
      render_enum_index_json(::BrandTypeEnum.to_a, 'brand_types')
    end

    def show
      render_enum_show_json(@object, 'brand_type')
    end

    private

    def set_object
      @object = ::BrandTypeEnum.to_a.find { |object| object[1].to_s == params[:id] }

      raise ::ActiveRecord::RecordNotFound if @object.nil?
    end
  end
end
