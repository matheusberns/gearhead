class WelcomesController < ::ApplicationController

  def index
      render :action => "new"
  end
end