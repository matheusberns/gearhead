class WelcomesController < ActionController::API #::ApplicationController

  def index
    render :json => { success: true }
  end
end