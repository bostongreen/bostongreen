module EventsHelper
  
  def start_time_hour(time)
    time.strftime("%l%p")
  end
  
  def human_readable_start_time(time)
    time.strftime("%A, %B #{time.day.ordinalize}")
  end
  
  def events_nav_uri
    "/events"
  end
end
