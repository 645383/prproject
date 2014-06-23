class CountriesController < ApplicationController
  include CountrySelector

  def show
    @country = Country.all[params[:format].to_i].name
  end

  def find_country
    country_no = select_country(params)
    redirect_to countries_show_path(country_no)
  end

end
