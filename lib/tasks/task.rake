require 'roo'

namespace :table do
  task migrate: :environment do
    xls = Roo::Spreadsheet.open(File.dirname(__FILE__) + '/table.xls')
    i = 2
    while  xls.sheet(0).row(i)[0] != nil
      @country = Country.create(name: xls.sheet(0).row(i)[0])
      @country.male_and_females.create(gender: 'male', height: xls.sheet(0).row(i)[1], physique: xls.sheet(0).row(i)[2], color_hair: xls.sheet(0).row(i)[3])
      @country.male_and_females.create(gender: 'female', height: xls.sheet(1).row(i)[1], physique: xls.sheet(1).row(i)[2], color_hair: xls.sheet(1).row(i)[3])
      i+=1
    end
  end
end
