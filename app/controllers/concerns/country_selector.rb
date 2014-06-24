module CountrySelector

  class Error < RuntimeError;
  end

  def select_country(params)

    params = set_params params

    gender = params[:gender] == "male" ? 'first' : 'last'
    people = Country.all.map { |c| c.people.send(gender) }

    heights = []
    weights = []
    hair_colors = []
    body_types = []

    people.each do |person|
      heights << person.height
      weights << person.weight
      hair_colors << Person::HAIR_SCALE[person.hair_color]
      body_types << Person::BODY_SCALE[person.body_type]
    end

    #%i(heights weights hair_colors body_types).each {|param| instance_variable_set("@#{param}_variation",
    #    eval("param.max - param.min"))}
    height_variation = heights.max - heights.min
    weight_variation = weights.max - weights.min
    hair_variation = hair_colors.max - hair_colors.min
    body_variation = body_types.max - body_types.min

    height = params[:height].to_f
    weight = params[:weight].to_f
    hair_color = params[:hair_color].to_f
    body_type = params[:body_type].to_f
    key = 0

    for i in 0...Country.count do
      index = ((height - heights[i])**2) / height_variation + ((weight - weights[i])**2) / weight_variation +
          ((hair_color - hair_colors[i])**2) / hair_variation + ((body_type - body_types[i])**2) / body_variation
      index_min = index if i == 0
      if index < index_min
        key = i
        index_min = index
      end
    end
    people[key].country_id
  end

  private

  def set_params(params)
    params[:hair_color] = Person::HAIR_SCALE[params[:hair_color]]
    params[:body_type] = Person::BODY_SCALE[params[:body_type]]

    Person::RANGES.each do |param, range|
      value = params[param].to_i
      unless range.include? value
        if params[param] == ""
          raise Error.new "Пустые значение не допускаются"
        else
          case param
          when :height
            raise Error.new value < range.min ?
                "Прости,но этот тест не для гномов" : "Привет, Гулливер!"
          when :weight
            raise Error.new value < range.min ? "Прости, но этот тест не для дистрофиков" :
                "Скорее всего ближайший спортзал не так и далеко!"
          end
        end
      end
    end
    params
  end

end