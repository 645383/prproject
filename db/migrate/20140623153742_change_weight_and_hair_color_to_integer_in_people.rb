class ChangeWeightAndHairColorToIntegerInPeople < ActiveRecord::Migration
  def change
    change_column :people, :weight, 'integer USING CAST(weight AS integer)'
    change_column :people, :hair_color, 'integer USING CAST(hair_color AS integer)'
  end
end
