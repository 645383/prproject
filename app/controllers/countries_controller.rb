require 'open-uri'
require 'net/http'

class CountriesController < ApplicationController
  include CountrySelector

  EXCEPT_RESULT_TABLE_DATA = [
      "<td class=\"anthem\""
  ]

  def show
    @country = Country.find(params[:format]).name.to_sym
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

  def render_wiki
    @wiki = fetch_url(params[:wiki])
    respond_to do |f|
      f.js
    end
  end

  private

  def fetch_url(url)

    url.gsub! ' ', '_'
    responce = Net::HTTP.get_response(URI.parse(url))
    if responce.is_a? Net::HTTPSuccess
      uri = open url
      lineas = uri.readlines
      str = ""
      lineas.each_index do |i|
        if lineas[i].match "<table class=\"infobox geography vcard\""
          c = 0
          excl_range = 0..0
          for k in i..lineas.length
            if lineas[k].match "<table"
              c += 1
            elsif lineas[k].match "</table"
              c -= 1
            end

            catch :brake do
              EXCEPT_RESULT_TABLE_DATA.each do |e|
                td = 0
                if lineas[k].match e
                  for ni in k..lineas.length
                    if lineas[ni].match "<td"
                      td += 1
                    elsif lineas[ni].match "</td"
                      td -= 1
                    end
                    #debugger
                    if td == 0
                      excl_range = k..(ni + 2)
                      throw :brake
                    end
                  end
                end
              end
            end
            #debugger

            str += lineas[k] unless excl_range.include? k

            if c == 0
              break
            end
          end
        end
      end
      str
    else
      nil
    end

  end

end