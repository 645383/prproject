class Country < ActiveRecord::Base
  has_many :people, dependent: :delete_all

  class << self

    def fill_from_spreadsheets(sheets)
      Country.destroy_all
      genders = %w(male, female)
      i = 2
      while  sheets.sheet(0).row(i)[0].present?
        if sheets.sheet(0).row(i)[1].present?
          @country = Country.new(name: sheets.sheet(0).row(i)[0])
          genders.each_with_index do |_, index|
            @country.people.new(
                gender: genders[index],
                height: sheets.sheet(index).row(i)[1],
                weight: sheets.sheet(index).row(i)[2],
                hair_color: sheets.sheet(index).row(i)[3],
                body_type: sheets.sheet(index).row(i)[4]
            )
          end
          @country.save
        end
        i+=1
      end
    end

  end

end
