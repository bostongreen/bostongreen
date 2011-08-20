require 'json'
require 'open-uri'


puts "###############################################\n"
puts "Adding park data\n"
contents = File.open(File.join(Rails.root,"db","fixtures","os-park.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash


count = 1
json_document["features"].each do |import_space|
  open_space = OpenSpace.new
  if import_space["properties"]["name"].blank?
    open_space.name = "Unnamed Park ##{count}"
    count +=1
  else
    open_space.name = import_space["properties"]["name"]
  end
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    open_space.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    open_space.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  open_space.tag_list = "park"
  open_space.description = import_space["properties"]["description"]
  open_space.save!

  open_space.ownership = import_space["properties"]["fee_owner"]
  
  puts "Open Space: #{open_space.id} name: #{open_space.name} created.\n"
end

puts "###############################################\n"
puts "Park Data added"
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Adding Neighborhoods\n"

contents = File.open(File.join(Rails.root,"db","fixtures","neighborhoods_single.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

json_document["features"].each do |import_space|
  neighborhood = Neighborhood.new
  neighborhood.name = import_space["properties"]["NAME"]
  neighborhood.location = Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  neighborhood.save!
  
  puts "Neighborhood: #{neighborhood.id} name: #{neighborhood.name} created."
end

puts "###############################################\n"
puts "Neighborhoods added"
puts "###############################################\n"
puts "\n\n"    


puts "###############################################\n"
puts "Adding Points of Interest\n"

contents = File.open(File.join(Rails.root,"db","fixtures","poi.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

json_document["features"].each do |import_space|
  feature = Feature.new
  feature.name = import_space["properties"]["NAME"]
  feature.category = import_space["properties"]["CATEGORY"]
  feature.tag_list << import_space["properties"]["CATEGORY"]
  feature.location = Point.from_coordinates(import_space["geometry"]["coordinates"],4326)
  feature.save!
  
  puts "Feature: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Points of Interest added"
puts "###############################################\n"
puts "\n\n"


puts "###############################################\n"
puts "Adding Community Gardens\n"

contents = File.open(File.join(Rails.root,"db","fixtures","communitygardens.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

json_document["features"].each do |import_space|
  feature = Feature.new
  feature.name = import_space["properties"]["name"]
  feature.category = import_space["properties"]["category"]
  feature.tag_list << feature.category
  feature.location = Point.from_coordinates(import_space["geometry"]["coordinates"],4326)
  feature.save!
  
  puts "Feature: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Community Gardens added"
puts "###############################################\n"
puts "\n\n"


puts "###############################################\n"
puts "Adding Nature Reserves\n"

contents = File.open(File.join(Rails.root,"db","fixtures","os-nature-reserve.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.new
  if import_space["properties"]["name"].blank?
    feature.name = "Unnamed Reserve ##{count}"
    count +=1
  else
    feature.name = import_space["properties"]["name"]
  end
  feature.description = import_space["properties"]["description"]
  feature.tag_list << "reserve"
  feature.dcr_park = import_space["properties"]["dcr_parkid"] if import_space["properties"]["dcr_parkid"]
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    feature.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    feature.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  feature.save!
  
  puts "OpenSpace: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Nature Reserves added"
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Adding Beaches\n"

contents = File.open(File.join(Rails.root,"db","fixtures","natural-beaches.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.new
  if import_space["properties"]["name"].blank?
    feature.name = "Unnamed Beach ##{count}"
    count +=1
  else
    feature.name = import_space["properties"]["name"]
  end
  feature.tag_list << "beach"
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    feature.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    feature.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  feature.description = import_space["properties"]["description"]  
  feature.save!
  
  puts "OpenSpace: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Beaches added"
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Adding Sports parks\n"

contents = File.open(File.join(Rails.root,"db","fixtures","sports.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.new
  
  categories = import_space["properties"]["category"]
    
  if import_space["properties"]["name"].blank?
    if categories.blank?
      feature.name = "Unnamed Field ##{count}"
      count +=1
    else
      feature.name = "#{categories.split(":").last.titlecase} Field"
    end
  else
    feature.name = import_space["properties"]["name"]
  end
  categories = import_space["properties"]["category"]
  
  unless categories.blank?
    categories.split(":").each do |cat|
      feature.tag_list << cat
    end
  end
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    feature.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    feature.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  feature.description = import_space["properties"]["description"]    
  feature.save!
  
  puts "OpenSpace: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Sports Parks added"
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Adding Gardens\n"

contents = File.open(File.join(Rails.root,"db","fixtures","leisure-garden.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.new
  if import_space["properties"]["name"].blank?
    feature.name = "Unnamed Garden ##{count}"
    count +=1
  else
    feature.name = import_space["properties"]["name"]
  end
  categories = import_space["properties"]["category"]
  
  feature.tag_list << "garden"
  
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    feature.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    feature.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  feature.description = import_space["properties"]["description"]    
  feature.save!
  
  puts "OpenSpace: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Gardens added"
puts "###############################################\n"

puts "###############################################\n"
puts "Adding Scenic Parks\n"

contents = File.open(File.join(Rails.root,"db","fixtures","os-scenic.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.new
  if import_space["properties"]["name"].blank?
    feature.name = "Unnamed Garden ##{count}"
    count +=1
  else
    feature.name = import_space["properties"]["name"]
  end
  categories = import_space["properties"]["category"]
  
  feature.tag_list << "scenic"
  
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    feature.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    feature.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  feature.description = import_space["properties"]["description"]    
  feature.save!
  
  puts "OpenSpace: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Scenic Parks added"
puts "###############################################\n"

puts "###############################################\n"
puts "Adding Historical Parks\n"

contents = File.open(File.join(Rails.root,"db","fixtures","os-historical.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.new
  if import_space["properties"]["name"].blank?
    feature.name = "Unnamed Garden ##{count}"
    count +=1
  else
    feature.name = import_space["properties"]["name"]
  end
  categories = import_space["properties"]["category"]
  
  feature.tag_list << "scenic"
  
  if import_space["geometry"]["type"] == "Polygon"
    poly_array = []
    poly_array << Polygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
    feature.location = MultiPolygon.from_polygons(poly_array,4326)
  else
    feature.location = MultiPolygon.from_coordinates(import_space["geometry"]["coordinates"],4326)
  end
  feature.description = import_space["properties"]["description"]    
  feature.save!
  
  puts "OpenSpace: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Historical Parks added"
puts "###############################################\n"

puts "###############################################\n"
puts "Adding DCR Info\n"

contents = File.open(File.join(Rails.root,"db","fixtures","dcr-park.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

count = 1
json_document["features"].each do |import_space|
  feature = OpenSpace.find_by_dcr_park(import_space["properties"]["parkid"])

  if feature
    feature.description = import_space["properties"]["description"]
    feature.directions = import_space["properties"]["mbta_directions"]
    #feature.photo =  open import_space["properties"]["photo_url"] unless import_space["properties"]["photo_url"].blank?
    feature.save!
  
    puts "OpenSpace: #{feature.id} name: #{feature.name} updated."
  end
end

puts "###############################################\n"
puts "DCR Info added"
puts "###############################################\n"

puts "###############################################\n"
puts "Adding Playgrounds\n"

contents = File.open(File.join(Rails.root,"db","fixtures","playgrounds.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

json_document["features"].each do |import_space|
  feature = Feature.new
  feature.name = import_space["properties"]["name"]
  feature.category = import_space["properties"]["category"]
  feature.tag_list << "playground"
  feature.location = Point.from_coordinates(import_space["geometry"]["coordinates"],4326)
  feature.save!
  
  puts "Feature: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Playgrounds added"
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Adding Public Art\n"

contents = File.open(File.join(Rails.root,"db","fixtures","publicart.json")) { |f| f.read }

json_document = JSON.parse(contents).to_hash

json_document["features"].each do |import_space|
  feature = Feature.new
  feature.name = import_space["properties"]["name"]
  feature.category = import_space["properties"]["category"]
  feature.description = import_space["properties"]["description"]
  feature.tag_list << "art"
  str_coord = import_space["geometry"]["coordinates"]
  float_coord = []
  float_coord << str_coord[1].to_f
  float_coord << str_coord[0].to_f      
  feature.location = Point.from_coordinates(float_coord,4326)
  feature.save!
  
  puts "Feature: #{feature.id} name: #{feature.name} created."
end

puts "###############################################\n"
puts "Public Art added"
puts "###############################################\n"
puts "\n\n"

puts "##############################################\n"
puts "Basic data migration complete.  Now advanced migrations."
puts "##############################################\n"
puts "\n\n"


puts "###############################################\n"
puts "Migrating Neighborhoods to Regions.\n"

neighborhood_names = Neighborhood.select("DISTINCT(name)")
puts "Original unique Neighborhoods: #{neighborhood_names.size}"

neighborhood_names.each do |neighborhood|
  shapes = Neighborhood.where("name = ?", neighborhood.name).map(&:location)
  
  multi_neighborhood = Region.new(:name => neighborhood.name,
    :location => MultiPolygon.from_polygons(shapes,4326)
  )
  multi_neighborhood.save!
end
puts "New Neighborhoods size: #{Region.all.count}"

puts "###############################################\n"
puts "Region migration complete."
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Importing tags of POI's to Open Spaces.\n"

all_open_spaces = OpenSpace.all

all_open_spaces.each do |open_space|
  points = Feature.where("ST_Intersects(location, ?)", open_space.location)
  
  points.each do |point|
    open_space.tag_list << point.tag_list
  end
  open_space.save!
  puts "Added Tag lists from POI's to #{open_space.name}"
end

puts "###############################################\n"
puts "Tag migration complete."
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Populating m:m relationship between Regions and OpenSpaces.\n"

neighborhoods = Region.all

neighborhoods.each do |neighborhood|
  open_spaces = OpenSpace.where("ST_Intersects( location , ?)", neighborhood.location)
  
  open_spaces.each do |open_space|
    neighborhood.open_spaces << open_space
  end
  neighborhood.save!
end

puts "###############################################\n"
puts "Region:OpenSpace relationship migration complete."
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Populating m:m relationship between Regions and POI's.\n"

neighborhoods = Region.all

neighborhoods.each do |neighborhood|
  features = Feature.where("ST_Intersects( location , ?)", neighborhood.location)
  
  features.each do |feature|
    neighborhood.features << feature
  end
  neighborhood.save!
end

puts "###############################################\n"
puts "Region:Feature relationship migration complete."
puts "###############################################\n"
puts "\n\n"

puts "###############################################\n"
puts "Populating m:m relationship between OpenSpaces and POI's.\n"

open_spaces = OpenSpace.all

open_spaces.each do |space|
  features = Feature.where("ST_Intersects( location , ?)", space.location)
  
  features.each do |feature|
    space.features << feature
  end
  space.save!
end

puts "###############################################\n"
puts "OpenSpace:Feature relationship migration complete."
puts "###############################################\n"
puts "\n\n"
