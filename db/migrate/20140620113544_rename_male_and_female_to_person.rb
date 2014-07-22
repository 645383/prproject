class RenameMaleAndFemaleToPerson < ActiveRecord::Migration
  def change
    rename_table :male_and_females, :people
  end
end
