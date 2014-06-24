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
      hair_colors << person.hair_color
      body_types << person.body_type
    end

    height_variation = heights.max - heights.min
    weight_variation = weights.max - weights.min
    hair_variation = hair_colors.max - hair_colors.min
    body_variation = body_types.max - body_types.min

    key = 0
    height = params[:height].to_f
    weight = params[:weight].to_f
    hair_color = params[:hair_color].to_f
    body_type = params[:body_type].to_f

    for i in 0...Country.count do
      index = ((height - heights[i])**2) / height_variation + ((weight - weights[i])**2) / weight_variation +
          ((hair_color - hair_colors[i])**2) / hair_variation + ((body_type - body_types[i])**2) / body_variation
      index_min = index if i == 0
      if index < index_min
        key = i
        index_min = index
      end
    end
    Country.all[key]
  end

  private

  def set_params(params)
    useful_params = [:height, :weight, :hair_color, :body_type]
    hair_scale = { 'черный' => 1, 'черный волнистый' => 2, 'шатен' => 3, 'шатен волнистый' => 4, 'рыжий' => 5,
        'белый' => 6 }
    body_scale = { 'худое' => 1, 'нормальное' => 2, 'полное' => 3 }

    params[:hair_color] = hair_scale[params[:hair_color]]
    params[:body_type] = body_scale[params[:body_type]]

    limits = [148..184, 60..95, 1..6, 1..3]

    limits.each_with_index do |limit, i|
      value = params[useful_params[i]].to_i
      unless limit.include? value
        if params[useful_params[i]] == ""
          raise Error.new "Пустые значение не допускаются"
        else
          case useful_params[i]
          when :height
            raise Error.new value < limit.min ?
                "Прости,но этот тест не для гномов" : "Привет, Гулливер!"
          when :weight
            raise Error.new value < limit.min ? "Прости, но этот тест не для дистрофиков" :
                "Скорее всего ближайший спортзал не так и далеко!"
          end
        end
      end
    end
    params
  end

end