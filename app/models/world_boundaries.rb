class WorldBoundaries < ActiveRecord::Base
  include GeoRuby::SimpleFeatures
  # class << self
  def self.generate_js_border_overlay(country_iso)
    factory = GeometryFactory.new
    wkt_parser = EWKTParser.new(factory)

    # borderDB = Mysql::new('localhost', 'root', '', 'pr_project')
    # res = borderDB.query("select name, iso2, AsText(ogc_geom), region from world_boundaries where iso2='#{country_iso}'")
    # res = WorldBoundaries.where(iso2: country_iso).first
    conn = PG.connect(dbname: 'pr_project', user: 'postgres', password: '645383')
    res = conn.exec("select ST_AsText(ogc_geom) from world_boundaries where iso2='#{country_iso}';")

    encoded_polygon_desc = ""
    remove_warnings_layer = "function removeBordersOverlay(map) {\n"
    add_borders = "function addBordersOverlay(map) {\n"
    res.each do |row|
      # name, iso2, multi_polygon, region = *row
      # binding.pry
      processed_polygon = wkt_parser.parse(row['st_astext'])
      encoded_polygon_desc << "var encodedPolygon_#{country_iso};\n"
      remove_warnings_layer << "encodedPolygon_#{country_iso}.setMap(null);\n"
      add_borders << "encodedPolygon_#{country_iso} = \
			new google.maps.Polygon({\n\
			clickable: false,\n\
			fillColor: \"blue\",\n\
			fillOpacity: 0.2,\n\
			geodesic: false,\n\
			map: map,\n\
			strokeColor: \"#000000\",\n\
			strokeOpacity: 0.6,\n\
			strokeWeight: 2,\n\
			zIndex: 10,\n\
			paths: ["
      factory.geometry.each do |landmass|
        landmass.rings.each do |ring|
          encoded = encode_by_reducing_pointcount(ring.points)
          add_borders << "google.maps.geometry.encoding.decodePath('"
          add_borders << encoded[0].gsub(/\\/, '\&\&') + "')"
          add_borders << "," unless ring == landmass.rings.last && landmass == factory.geometry.last
          add_borders << "\n"
        end
      end
      add_borders << "]});\n return encodedPolygon_#{country_iso};\n"
    end
    remove_warnings_layer << "\n}"
    add_borders << "\n}"

    File.open("#{Rails.root}/app/assets/javascripts/bordersOverlay.js", 'w') { |f|
      f.write(encoded_polygon_desc + "\n")
      f.write(remove_warnings_layer + "\n")
      f.write(add_borders)
    }
  end

  def self.encode_by_reducing_pointcount(points)
    dlat = plng = plat = dlng = 0
    res = ["", ""]
    index = -1
    for point in points
      index += 1
      #straight point reduction algorithm: use every 5th point only
      #use all points if their total count is less than 16
      next if index.modulo(5) != 0 && points.size > 16
      late5 = (point.y * 1e5).floor
      lnge5 = (point.x * 1e5).floor
      dlat = late5 - plat;
      dlng = lnge5 - plng;
      plat = late5;
      plng = lnge5;
      res[0] << encode_signed_number(dlat)
      res[0] << encode_signed_number(dlng)
      res[1] << encode_number(3)
    end
    return res
  end

  def self.encode_signed_number(num)
    sig_num = num << 1
    sig_num = ~sig_num if sig_num < 0
    encode_number(sig_num)
  end

  def self.encode_number(num)
    res = ""
    while num >= 0x20 do
      res << ((0x20 | (num & 0x1f)) + 63).chr
      num >>= 5
    end
    res << (num + 63).chr
    return res
  end
  # end
end
