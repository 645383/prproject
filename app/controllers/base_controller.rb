class BaseController < ApplicationController

  def index
  end

  def select_language
    redirect_to root_path
  end

end
