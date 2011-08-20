require 'boston_events_parser'
require 'open-uri'

events_feed = BostonEventsParser.new

events_feed.elements.each do |event|
  event_record = Event.find_or_create_by_boston_event_id(event[:id])
  
  event_record.name = event[:name]
  event_record.description = event[:description]
  event_record.url = event[:url]
  event_record.boston_event_id = event[:id]
  event_record.location = Point.from_x_y(event[:lng].to_f, event[:lat].to_f, 4326)
  event_record.start_time = event[:start_time]
  event_record.end_time = event[:end_time]
  event_record.photo = open event[:image] if event[:image]
  
  if event_record.save
    if event_record.new_record?
      puts "New event: #{event_record.name} created."
    else
      puts "Event: #{event_record.name} updated."
      event_record.open_spaces = []
      
      open_spaces = OpenSpace.within(event_record.location,0.002)
      open_spaces.each do |open_space|
        event_record.open_spaces << open_space
      end
      event_record.save!
    end
  end
end

module ImportEvents
end