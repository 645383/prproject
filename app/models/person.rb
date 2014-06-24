class Person < ActiveRecord::Base
  belongs_to :country

  validate
end
