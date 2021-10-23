json.array!(@calendars) do |event|
  json.start event.start
  json.end event.end
  json.title "walk_count: #{event.count}"
end