# Written by Florin Duroiu, see
# http://blog.newsplore.com/2009/03/01/political-boundaries-overlay-google-maps-2
#
# Fixed for Google Maps API v3 by Ives van der Flaas <ives.vdf@gmail.com>
# Be sure to add 
#
# <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
# <script type="text/javascript" src="http://maps.google.com/maps/api/js?libraries=geometry&sensor=false"></script>
# 
# to the including HTML page or it will not work (the decode function for encoded coordinates is in the geometry library.)


require 'mysql'
require 'geo_ruby'

include GeoRuby::SimpleFeatures

def generate_js_border_overlay(output_file)
	factory = GeometryFactory.new
	wkt_parser = EWKTParser.new(factory)

  borderDB = Mysql::new('localhost', 'root', '645383', 'my_database')
	res = borderDB.query("select name, iso2, AsText(ogc_geom), region from world_boundaries where iso2='DE'")
	encoded_polygon_desc = "";
	remove_warnings_layer = "function removeBordersOverlay(map) {\n"
	add_borders = "function addBordersOverlay(map) {\n"
	res.each do |row|
		name, iso2, multi_polygon, region = *row
		processed_polygon = wkt_parser.parse(multi_polygon);
		encoded_polygon_desc << "var encodedPolygon_#{iso2};\n"
		remove_warnings_layer << "encodedPolygon_#{iso2}.setMap(null);\n"
		add_borders << "encodedPolygon_#{iso2} = \
			new google.maps.Polygon({\n\
			clickable: false,\n\
			fillColor: \"#000000\",\n\
			fillOpacity: 0.9,\n\
			geodesic: false,\n\
			map: map,\n\
			strokeColor: \"#000000\",\n\
			strokeOpacity: 1.0,\n\
			strokeWeight: 4,\n\
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
		add_borders << "]});\n"
	end
	
	
	remove_warnings_layer << "\n}"
	add_borders << "\n}"
	File.open(output_file, 'w') {|f|
		f.write(encoded_polygon_desc + "\n")
		f.write(remove_warnings_layer + "\n")
		f.write(add_borders)
	}
end

def encode_by_reducing_pointcount(points)
	dlat = plng = plat = dlng = 0
	res = ["",""]
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

def encode_signed_number(num)
	sig_num = num << 1
	sig_num = ~sig_num if sig_num < 0
	encode_number(sig_num)
end

def encode_number(num)
	res = ""
	while num  >= 0x20 do
		res << ((0x20 | (num & 0x1f)) + 63).chr
		num >>= 5
	end
	res << (num + 63).chr
	return res
end

generate_js_border_overlay("bordersOverlay.js")
