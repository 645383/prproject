# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sql = File.read("#{Rails.root}/db/wb_dump.sql")
# sql.force_encoding('binary')
statements = sql.split(/;$/)
statements.pop  # the last empty statement
statements.shift
connection = ActiveRecord::Base.connection
ActiveRecord::Base.transaction do
  statements.each do |statement|
    # statement.gsub!("GeometryFromText", "ST_GeomFromText")
    sub_string = /.*GeometryFromText\((.*)\'.*/.match(statement)[1] + '\''
    sub_statement = statement.gsub!(/GeometryFromText\((.*)/, sub_string) + ');'
    connection.execute(sub_statement)
  end
end
