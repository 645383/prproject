class RenameColumnsInPeople < ActiveRecord::Migration
  def change
    rename_column :people, :physique, :weight
    rename_column :people, :color_hair, :hair_color
  end
end
