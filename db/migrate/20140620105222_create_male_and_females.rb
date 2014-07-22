class CreateMaleAndFemales < ActiveRecord::Migration
  def change
    create_table :male_and_females do |t|
      t.integer :height
      t.text :color_hair
      t.text :physique
      t.integer :country_id
      t.string :gender

      t.timestamps
    end
  end
end
