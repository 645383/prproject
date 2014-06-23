require 'roo'

namespace :table do
  task migrate: :environment do
    debugger
    sheets = Roo::Spreadsheet.open(Rails.root.to_s + '/public/table.xls')
    Country.fill_from_spreadsheets(sheets)
  end
end
