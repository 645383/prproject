class ChangeBodyTypeAndHairColorToStringInPeople < ActiveRecord::Migration
  def change
    change_column :people, :body_type, :string
    change_column :people, :hair_color, :string
  end
end
