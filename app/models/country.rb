class Country < ActiveRecord::Base
  has_many :people, dependent: :delete_all

  class << self

    def fill_from_spreadsheets(sheets)
      Country.destroy_all
      genders = %w(male female)
      #ranges = { height: min_height = 1000..max_height = 0, weight: min_weight = 1000..max_weight = 0,
      #    hair_color: min_hair = 1000..max_hair = 0, body_type: min_body = 1000..max_body = 0 }
      i = 2
      while  sheets.sheet(0).row(i)[0].present?
        if sheets.sheet(0).row(i)[1].present?
          @country = Country.new(name: sheets.sheet(0).row(i)[0])
          genders.each_with_index do |_, index|
            height = sheets.sheet(index).row(i)[1]
            weight = sheets.sheet(index).row(i)[2]
            hair_color = Person::NORMAL_HAIR[sheets.sheet(index).row(i)[3]]
            body_type = Person::NORMAL_BODY[sheets.sheet(index).row(i)[4]]
            @country.people.new(
                gender: genders[index],
                height: height,
                weight: weight,
                hair_color: hair_color,
                body_type: body_type
            )
            #min_height = height < min_height ? height : min_height
            #min_weight = weight < min_weight ? weight : min_weight
            #max_height = height > max_height ? height : max_height
            #max_weight = weight > max_weight ? weight : max_weight
          end
          @country.save
        end
        i+=1
      end
      Person::RANGES
    end

  end

end
