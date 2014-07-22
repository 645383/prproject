class Country < ActiveRecord::Base

  include Countries
  has_many :people, dependent: :destroy


  def self.fill_from_spreadsheets(sheets)
    puts "Deleting old records..."
    Country.destroy_all
    genders = %w(male female)
    i = 2
    while  sheets.sheet(0).row(i)[0].present?
      if sheets.sheet(0).row(i)[1].present?
        @country = Country.new(name: Countries::COUNTRIES[sheets.sheet(0).row(i)[0]].to_s)
        puts "Creating country #{@country.name}"
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
        end
        @country.save
        @country.people.each { |p| puts "---> #{p.gender}, #{p.height}, #{p.weight}, #{p.hair_color}, #{p.body_type}" }
      end
      i+=1
    end
  end

end
