class ChangeWeightAndHairColorToIntegerInPeople < ActiveRecord::Migration
  def change
    # integer = Rails.env == 'production' ? 'integer USING CAST(weight AS integer)' : :integer
    change_column :people, :weight, :integer
    change_column :people, :hair_color, :integer
  end
end
