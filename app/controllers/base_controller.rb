class BaseController < ApplicationController

  def index
    @page_second = false
  end

  def test_form
    @page_second = true
  end

  def select_language
    redirect_to root_path
  end



end
