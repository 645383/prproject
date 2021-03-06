class Person < ActiveRecord::Base
  belongs_to :country

  NORMAL_HAIR = { 'черн' => 'черный', 'черн+волнистый' => 'черный', 'шатен+волн' => 'шатен',
      'блонд' => 'блондин', 'шатен' => 'шатен', 'рыжий' => 'рыжий' }
  NORMAL_BODY = { 'худой' => 'худое', 'спортивный' => 'спортивное', 'полный' => 'полное' }
  HAIR_SCALE = { 'черный' => 1, 'шатен' => 2, 'рыжий' => 3, 'блондин' => 4 }
  BODY_SCALE = { 'худое' => 1, 'спортивное' => 2, 'полное' => 3 }
  RANGES = { gender: 1..2, height: 100..250, weight: 30..150, foot_size: 35..45, hair_color: 1..6, body_type: 1..3}
end
