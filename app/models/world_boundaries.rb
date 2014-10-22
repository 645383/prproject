class WorldBoundaries < ActiveRecord::Base
  include GeoRuby::SimpleFeatures

  def self.generate_js_border_overlay(country_iso)
    factory = GeometryFactory.new
    wkt_parser = EWKTParser.new(factory)

    res = WorldBoundaries.where(iso2: country_iso)

    borders = '['
    res.each do |row|
      processed_polygon = wkt_parser.parse(row.ogc_geom)
      factory.geometry.each do |landmass|
        landmass.rings.each do |ring|
          encoded = encode_by_reducing_pointcount(ring.points)
          borders << "google.maps.geometry.encoding.decodePath('#{encoded[0].gsub(/\\/, '\&\&')}')"
          borders << "," unless ring == landmass.rings.last && landmass == factory.geometry.last
        end
      end
      borders << ']'
    end
    borders
  end

  def self.encode_by_reducing_pointcount(points)
    dlat = plng = plat = dlng = 0
    res = ['', '']
    index = -1
    for point in points
      index += 1
      next if index.modulo(5) != 0 && points.size > 16
      late5 = (point.y * 1e5).floor
      lnge5 = (point.x * 1e5).floor
      dlat = late5 - plat
      dlng = lnge5 - plng
      plat = late5
      plng = lnge5
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
end
