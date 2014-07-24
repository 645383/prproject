class AddFootSizeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :foot_size, :integer
  end
end
