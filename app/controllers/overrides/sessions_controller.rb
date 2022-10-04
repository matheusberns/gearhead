# frozen_string_literal: true

module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    include Renders
    include ActiveDirectoryLogin

    def create
      render_login_field_error and return unless login_field.present?
      return render_create_error_bad_credentials unless resource_params[:password].present?

      @resource = find_active_devise_resource

      if valid_devise_resource? || valid_active_directory_resource?
        return render_create_error_bad_credentials if not_login_valid?

        @token = @resource.create_token
        @resource.save

        return render_errors_json(@resource.errors.messages) if @resource.errors.messages.any?

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?

        render json: { success: "Login com sucesso", token: @token, data: Overrides::SessionSerializer.new(@resource, root: false).serializable_hash, meta: @meta }, status: 201
      else
        render_create_error_bad_credentials
      end
    end

    protected

    def render_create_success
      render_show_json(@resource, SessionSerializer, 'user', 200)
    end

    private

    def not_login_valid?
      valid_password = @resource.valid_password?(resource_params[:password])

      ((@resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password }) || !valid_password) && !@active_directory&.authenticated? && !@active_directory&.persisted?
    end

    def render_account_not_found_error
      render json: { errors: { base: I18n.t('.devise_token_auth.sessions.account_not_found') } }, status: 401
    end

    def render_create_error_bad_credentials
      render json: { errors: { base: @exceeded_attempts ? I18n.t('.devise_token_auth.sessions.bad_credential_exceeded_attempts') : I18n.t('.devise_token_auth.sessions.bad_credentials') } }, status: 401
    end

    def render_login_field_error
      render json: { errors: { base: I18n.t('.devise_token_auth.sessions.login_not_found') } }, status: 401
    end

    def login_field
      permitted_auth_keys = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys)

      old_version_login = permitted_auth_keys.include?(:email)

      @login_field = old_version_login ? :email : :login
    end

    def find_active_devise_resource
      @login_value = get_case_insensitive_field_from_resource_params(@login_field)
      return if @login_value.nil?

      login_with_email = ::Devise.email_regexp.match? @login_value

      if login_with_email
        ::User.active(true).find_by('email' => @login_value)
      else
        only_numbers = @login_value.gsub(/\D/, '')
        return unless only_numbers.present?

        user = ::User.active(true).find_by('cpf' => only_numbers)
        user = ::User.active(true).find_by('identification_number' => only_numbers) if user.nil?
        user
      end
    end

    def valid_devise_resource?
      @resource && valid_params?(@login_field, @login_value) && (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
    end
  end
end
