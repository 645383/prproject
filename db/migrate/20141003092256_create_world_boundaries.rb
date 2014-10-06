class CreateWorldBoundaries < ActiveRecord::Migration
  def change
    # execute "CREATE EXTENSION postgis;"
    create_table :world_boundaries do |t|
      t.text :fips
      t.text :iso2
      t.text :iso3
      t.integer :un
      t.text :name
      t.integer :area
      t.integer :pop2005
      t.integer :region
      t.integer :subregion
      t.float :lon
      t.float :lat
      t.text :ogc_geom
      # t.geometry :ogc_geom
      # t.timestamps
    end
  end
end
