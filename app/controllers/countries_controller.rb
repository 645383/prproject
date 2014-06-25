class CountriesController < ApplicationController
  include CountrySelector

  def show
    @country = Country.find(params[:format]).name
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to root_path
  end

  def find_country
    redirect_to countries_show_path(select_country(params))
  rescue Error => e
    #render :json => { :error => e.message }, :status => :unprocessable_entity
    flash[:notice] = e.message
    redirect_to root_path
  end

end
