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
statements = sql.split(/;/)
statements.pop  # the last empty statement
connection = ActiveRecord::Base.connection
ActiveRecord::Base.transaction do
  statements.each do |statement|
    connection.execute(statement)
  end
end
