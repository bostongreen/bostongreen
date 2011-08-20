require 'open-uri'

##
# BostonEventsParser takes a feed from calendar.boston.com and constructs an array of helpful events from it!
## 
class BostonEventsParser
  
  attr_accessor :elements
  
  def initialize(host=nil,body=nil)
    host ||= "calendar.boston.com"
    body ||= "/search?cat=9&new=n&rss=1&srad=100&srss=100&st=event&svt=text&swhat=&swhen=&swhere="
    http = Net::HTTP.new(host)
    request = Net::HTTP::Get.new(body)
    response = http.request(request)
  
    rss = REXML::Document.new(response.body).root
    @elements =[]
    rss.elements.each("*/item") do |element|
      single_element = {
        :id => element.elements["id"].text,
        :name => element.elements["title"].text,
        :description => element.elements["description"].text,
        :url => element.elements["link"].text,
        :lat => element.elements["geo:lat"].text,
        :lng => element.elements["geo:long"].text,
        :start_time => element.elements["xCal:dtstart"].text,
        :end_time => element.elements["xCal:dtend"].text
      }
      # because the image is fairly optional.  Everything else seems to be mandatory.
      single_element[:image] = element.elements["images"].elements["url"].text if element.elements["images"].elements["url"]
      
      @elements << single_element
    end
  end
end