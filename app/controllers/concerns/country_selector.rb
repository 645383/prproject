module CountrySelector

  class Error < RuntimeError;
  end

  def select_country(params)
    #params = check_exceptional_params params

    gender = params[:gender].to_i == 1 ? 'first' : 'last'
    people = Country.all.map { |c| c.people.send(gender) }

    heights = []
    weights = []
    foot_sizes =[]
    hair_colors = []
    body_types = []

    people.each do |person|
      heights << person.height
      weights << person.weight
      foot_sizes << person.foot_size
      hair_colors << Person::HAIR_SCALE[person.hair_color.force_encoding('utf-8')]
      body_types << Person::BODY_SCALE[person.body_type.force_encoding('utf-8')]
    end

    height_variation = heights.max - heights.min
    weight_variation = weights.max - weights.min
    foot_variation = foot_sizes.max - foot_sizes.min
    hair_variation = hair_colors.max - hair_colors.min
    body_variation = body_types.max - body_types.min

    height = params[:height].to_f
    weight = params[:weight].to_f
    foot_size = params[:foot_size].to_f
    hair_color = params[:hair_color].to_f
    if params[:body_type].to_f == 1.0 || params[:body_type].to_f == 2.0
      body_type = 1.0
    elsif params[:body_type].to_f == 4.0 || params[:body_type].to_f == 5.0
      body_type = 3.0
    else
      body_type = params[:body_type].to_f
    end
    indexes = []
    ind = []

    for i in 0...Country.count do
      indexes << ((height - heights[i])**2) / height_variation + ((weight - weights[i])**2) / weight_variation +
          ((hair_color - hair_colors[i])**2) / hair_variation + ((body_type - body_types[i])**2) / body_variation +
          ((foot_size - foot_sizes[i])**2) / foot_variation
    end
    indexes.sort.first(5).each do |n|
      ind << indexes.index(n) unless ind.include? indexes.index n
      ind << indexes.rindex(n) unless ind.include? indexes.rindex n
    end
    country_ids = []
    ind.each { |i| country_ids << people[i].country_id }
    country_ids
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