json.array!(@tasks) do |task|
  json.id task.id
  json.title task.parent_id ? "[#{task.parent_id}] #{task.id}_#{task.name}" : "#{task.id}_#{task.name}"
  json.start task.start_time
  json.end task.end_time
  json.color (task.end_time || Time.now ) < Time.now ? "#D82148" : "#6EBF8B"
  json.url event_task_path(event_id: task.event_id, id: task.id)
  if task.start_time && task.end_time
    json.allDay true if task.start_time.day != task&.end_time.day
  end
end
