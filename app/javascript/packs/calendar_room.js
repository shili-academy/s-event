var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  headerToolbar: {
    left: 'dayGridMonth,timeGridWeek,timeGridDay',
    center: 'title',
    right: 'prev,next'
  },
  timeZone: 'local',
  initialView: 'dayGridMonth',
  events: `${gon.event_id}.json`,
  selectable: true,
  eventColor: '#22577A',
  droppable: true,
  editable: true,
  eventDrop: function (info) {
    change_time(info)
  },
  eventResize: function (info) {
    change_time(info)
  },
  dateClick: function (info) {
    $("#task_start_time").val(info.date.toISOString().slice(0, 16))
    $("#task_end_time").val(info.date.toISOString().slice(0, 16))
    var myModal = new bootstrap.Modal($("#exampleModal"), {});
    myModal.show();
  },
  select: function (info) {
    $("#task_start_time").val(info.start.toISOString().slice(0, 16))
    $("#task_end_time").val(info.end.toISOString().slice(0, 16))
    var myModal = new bootstrap.Modal($("#exampleModal"), {});
    myModal.show();
  }
});

calendar.render();

function change_time(info) {
  var event = info.event;
  var id = event.id;
  var start_time = moment(event.start).format("YYYY-MM-DD HH:mm:ss")
  var end_time = moment(event.end).format("YYYY-MM-DD HH:mm:ss")
  $.ajax({
    type: 'GET',
    url: gon.url,
    data: {
      id: id,
      event_id: gon.event_id,
      start_time: start_time,
      end_time: end_time,
      authenticity_token: $('[name="csrf-token"]')[0].content
    }
  });
}
