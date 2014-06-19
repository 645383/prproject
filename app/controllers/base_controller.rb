class BaseController < ApplicationController
  H = [120..150, 151..170, 171..190, 191..210, 211..250]
  W = [50..60, 61..80, 81..120]
  BT = %w{slim normal fat}
  HC = %w{dark blond red}
  #FS = []
  #HC = %w{dark blond red}

  COUNTRIES = {
      'C1' => [H[0], W[0], BT[0], HC[0]],
      'C2' => [H[0], W[0], BT[0], HC[1]],
      'C3' => [H[0], W[0], BT[1], HC[1]],
      'C4' => [H[0], W[1], BT[1], HC[1]],
      'C5' => [H[1], W[1], BT[1], HC[1]],
      'C6' => [H[1], W[1], BT[1], HC[2]],
      'C7' => [H[1], W[1], BT[2], HC[2]]
  }

  def index

  end

  def find_country
      @p = select_country COUNTRIES, params
    @c = COUNTRIES[@p]
  end

  def select_country(countries_hash, params)

    score = {}
    countries_hash.each { |k, v| score[k] = [] }

    countries_hash.each do |country, data|
      #debugger
      score[country] << data[0].include?(params[:height].to_i)
      score[country] << data[1].include?(params[:weight].to_i)
      score[country] << (data[2] == (params[:body_type]))
      score[country] << (data[3] == (params[:hair_color]))
    end
    c = 0
    country = ''
    score.each do |k, v|
      t = v.select{|n| n == true}.count
      if t > c
        c = t
        country = k
      else
        c = c
      end
    end
    country
  end

end
