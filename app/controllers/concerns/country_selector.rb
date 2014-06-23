module CountrySelector

  def select_country(params)

    gender = params[:gender][:gender] == "male" ? 'first' : 'last'
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

    result_key = 0
    height = params[:height].to_f
    weight = params[:weight].to_f
    hair_color = params[:hair_color].to_f
    body_type = params[:body_type].to_f

    for i in 0...Country.count do
      index = ((height - heights[i])**2) / height_variation + ((weight - weights[i])**2) / weight_variation +
          ((hair_color - hair_colors[i])**2) / hair_variation + ((body_type - body_types[i])**2) / body_variation
      index_min = index if i == 0
      if index < index_min
        result_key = i
        index_min = index
      end
    end
    result_key
  end

end