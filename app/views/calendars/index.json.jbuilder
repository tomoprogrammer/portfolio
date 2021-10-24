json.array!(@calendars) do |event|
  json.start event.start
  json.end event.end
  json.title "記録あり"
  json.url "/walks?date=#{event.start.strftime("%Y-%m-%d")}"
end