require 'roo'

#s = Roo::OpenOffice.new("myspreadsheet.ods")      # loads an OpenOffice Spreadsheet
s = Roo::Excel.new("ie_data.xls")
#s.default_sheet = s.sheets.first
p s.cell(20,1)