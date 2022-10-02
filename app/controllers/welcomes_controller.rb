class WelcomesController < ::ApplicationController
  skip_before_action :check_authentication

  def index
    render :new
  end
end