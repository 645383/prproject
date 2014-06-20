require 'roo'

#s = Roo::OpenOffice.new("myspreadsheet.ods")      # loads an OpenOffice Spreadsheet
#s = Roo::Excel.new('ie_data.xls')
#s = Roo::Excel.new('table.xls')
#p s.cell(2,2)

#p s.first_column
#p s.cell(2, 2)
#p s.info
#i=1
#while i < 11
#  print "#{i} "
#  i+=1
#end
require 'spreadsheet'
xls = Roo::Spreadsheet.open('table.xls')
#x = xls.sheet(0).row(3)

#while xls.sheet(0).row(i)[0] != nil
#  x = xls.sheet(0).row(i)
#  arr_obj.push({ height: x[1],
#      weight: x[2],
#      foot_size: x[3]
#  })
#  i+=1
#end
#for i in xls.sheet(0).column(1)
#  if i != "страна"
#    @country = Country.create(name: i)
#
#    @country.create_male
#  end
#end
#i = 2
#while  xls.sheet(0).row(i)[0] != nil
#  @country = Country.create(name: xls.sheet(0).row(i)[0])
#  @country.create_male(height: xls.sheet(0).row(i)[1], weight: xls.sheet(0).row(i)[2], foot_size:xls.sheet(0).row(i)[3])
#  i+=1
#end
p x = xls.sheet(0).row(2)[0]


