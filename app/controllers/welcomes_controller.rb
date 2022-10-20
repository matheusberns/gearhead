class WelcomesController < ::ApplicationController
  skip_before_action :check_authentication

  def index
    render json: { success: true }

  end
end