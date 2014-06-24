class AddColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :body_type, :integer
  end
end
