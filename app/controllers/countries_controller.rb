class CountriesController < ApplicationController
  include CountrySelector

  def show
    #@show_page = true
    @country = Country.find(params[:format]).name.to_sym
      #debugger

  rescue Exception => e
    flash[:notice] = e.message
    redirect_to root_path
  end

  def find_country
    redirect_to countries_show_path(select_country(params))
  rescue Error => e
    flash[:notice] = e.message
    redirect_to root_path
  end

end
