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
    @res = select_country(COUNTRIES, params)

    @c = @res[0]
    @p = @res

  end

  def select_country(countries_hash, params)

    score = {}
    countries_hash.each { |k, v| score[k] = [] }

    countries_hash.each do |country, data|
      score[country] << data[0].include?(params[:height].to_i)
      score[country] << data[1].include?(params[:weight].to_i)
      score[country] << (data[2] == (params[:body_type]))
      score[country] << (data[3] == (params[:hair_color]))
    end

    counter = 0

    hash = {}
    country = ''
    score.each do |k, v|
      prior_count = 0
      v.each_with_index do |v, i|
        prior_count += i + 1 if v == true
        hash[k] = prior_count
      end
    end
    hash
  end

  def serch_country
    height = params[:height]
    color_hair = params[:hair_color]
    gender = params[:gender]
    body_type = params[:body_type]

    country = Country.find_by()

  end

end
