module CountrySelector

  class Error < RuntimeError;
  end

  def select_country(params)
    params = check_exceptional_params params

    gender = params[:gender].to_i == 1 ? 'first' : 'last'
    people = Country.all.map { |c| c.people.send(gender) }

    heights = []
    weights = []
    hair_colors = []
    #body_types = []

    people.each do |person|
      heights << person.height
      weights << person.weight
      hair_colors << Person::HAIR_SCALE[person.hair_color]
      #body_types << Person::BODY_SCALE[person.body_type]
    end

    height_variation = heights.max - heights.min
    weight_variation = weights.max - weights.min
    hair_variation = hair_colors.max - hair_colors.min
    #body_variation = body_types.max - body_types.min

    height = params[:height].to_f
    weight = params[:weight].to_f
    hair_color = params[:hair_color].to_f
    #body_type = params[:body_type].to_f
    key = 0

    for i in 0...Country.count do
      index = ((height - heights[i])**2) / height_variation + ((weight - weights[i])**2) / weight_variation +
          ((hair_color - hair_colors[i])**2) / hair_variation # + ((body_type - body_types[i])**2) / body_variation
      index_min = index if i == 0
      if index < index_min
        key = i
        index_min = index
      end
    end

    people[key].country_id
  end

  private

  def check_exceptional_params(params)
    Person::RANGES.each do |param, range|
      value = params[param].to_i
      unless range.include? value
        if params[param] == "" || params[param] == nil
          raise Error.new t("exceptions.no_input")
        else
          case param
            when :height
              raise Error.new value < range.min ? t('exceptions.height_s') : t('exceptions.height_b')
            when :weight
              raise Error.new value < range.min ? t('exceptions.weight_s') : t('exceptions.weight_b')
          end
        end
      end
    end
    params
  end

end