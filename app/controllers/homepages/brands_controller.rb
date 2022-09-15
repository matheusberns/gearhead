# frozen_string_literal: true

module Homepages
  class BrandsController < ::ApiController
    before_action :validate_permission, except: :autocomplete
    before_action :set_brand, only: %i[show update destroy]

    def index
      @brands = brand_list

      @brands = apply_filters(@brands, :active_boolean,
                              :by_name)

      render_index_json(@brands, Brands::IndexSerializer, 'brands')
    end

    def autocomplete
      @brands = Brand.autocomplete

      @brands = apply_filters(@brands, :active_boolean, :by_search)

      render_index_json(@brands, Brands::AutocompleteSerializer, 'brands')
    end

    def show
      render_show_json(@brand, Brands::ShowSerializer, 'brand')
    end

    def create
      @brand = Brand.new(brand_create_params)

      if @brand.save
        render_show_json(@brand, Brands::ShowSerializer, 'brand', 201)
      else
        render_errors_json(@brand.errors.messages)
      end
    end

    def update
      if @brand.update(brand_update_params)
        render_show_json(@brand, Brands::ShowSerializer, 'brand')
      else
        render_errors_json(@brand.errors.messages)
      end
    end

    def destroy
      if @brand.destroy
        render_success_json
      else
        render_errors_json(@brand.errors.messages)
      end
    end

    def recover
      @brand = brand_list.active(false).find(params[:id])

      if @brand.recover
        render_show_json(@brand, Brands::ShowSerializer, 'brand')
      else
        render_errors_json(@brand.errors.messages)
      end
    end

    private

    def validate_permission
      render_error_json(status: 405) unless find_permission([::PermissionCodeEnum::BRAND_MANAGE])
    end

    def brand_list
      Brand.list
    end

    def set_brand
      @brand = brand_list.activated.find(params[:id])
    end

    def brand_create_params
      brand_params.merge(created_by_id: @current_user.id)
    end

    def brand_update_params
      brand_params.merge(updated_by_id: @current_user.id)
    end

    def brand_params
      params.require(:brand).permit(:name)
    end
  end
end
