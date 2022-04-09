document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    headerToolbar: {
      left: 'dayGridMonth,timeGridWeek,timeGridDay',
      center: 'title',
      right: 'prev,next'
    },
    timeZone: 'local',
    initialView: 'dayGridMonth',
    events: `${room_id}.json`,
    selectable: true,
    eventColor: '#22577A'
  });
  calendar.render();
});
