# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sql = File.read("#{Rails.root}/db/wb_dump.sql")
sql.force_encoding('binary')
#p sql.encoding
statements = sql.split(/;$/)
# binding.pry
statements.pop  # the last empty statement
statements.shift
connection = ActiveRecord::Base.connection
# connection.close
# connection = ActiveRecord::Base.connection
ActiveRecord::Base.transaction do
  #begin
  statements.each do |statement|
    statement.gsub!("GeometryFromText", "ST_GeomFromText")
    # statement.gsub!(/\'/){ %q(') }
    connection.execute(statement)
  end
  #rescue ActiveRecord::StatementInvalid => e
  #  p e.message
  #end
end
