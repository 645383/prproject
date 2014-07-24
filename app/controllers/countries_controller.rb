require 'open-uri'

class CountriesController < ApplicationController
  include CountrySelector

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
    responce = Net::HTTP.get_response( URI.parse( url ) )
    if responce.is_a? Net::HTTPSuccess
      #debugger
      #resp = Nokogiri::HTML open(url)
      #responce.body.force_encoding("UTF-8").slice /<table class="infobox geography vcard".*<\/table>/
      #resp.css(".infobox.geography vcard")
      uri = open url
      lineas = uri.readlines
      str = ""
      lineas.each_index do |i|
        if lineas[i].match "<table class=\"infobox geography vcard\""
          #p lineas[i]
          c = 0
          for k in i..lineas.length
            if lineas[k].match "<table"
              c += 1
            elsif lineas[k].match "</table"
              c -= 1
            end
            str += lineas[k]

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