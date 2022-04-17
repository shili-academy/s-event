json.array!(@tasks) do |task|
  json.id task.id
  json.groupId task.parent_id
  json.title task.name
  json.start task.start_time
  json.end task.end_time
  json.url event_task_path(event_id: task.event_id, id: task.id)
  if task.start_time && task.end_time
    json.allDay true if task.start_time.day != task&.end_time.day
  end
end
