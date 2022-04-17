var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  themeSystem: 'bootstrap5',
  headerToolbar: {
    left: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth,listWeek',
    center: 'title',
    right: 'today,prevYear,prev,next,nextYear'
  },
  footerToolbar: {
    center: '',
    right: 'prev,next'
  },
  views: {
    dayGridMonth: {
      buttonText: 'Month',
    },
    timeGridWeek: {
      buttonText: 'Week',
    },
    timeGridDay: {
      buttonText: 'Day',
    },
    listMonth: {
      buttonText: 'List Month',
    },
    listWeek: {
      buttonText: 'List Week'
    }
  },
  timeZone: 'UTC',
  locale: 'vi',
  initialView: 'dayGridMonth',
  events: `${gon.id_json}.json`,
  selectable: true,
  droppable: true,
  editable: true,
  eventClick: function (info) {
    info.jsEvent.preventDefault();
    if (info.event.url) {
      $.ajax({
        type: 'GET',
        dataType: 'script',
        url: info.event.url,
      });
    }
  },
  eventDrop: function (info) {
    update_task(info)
  },
  eventResize: function (info) {
    update_task(info)
  },
  dateClick: function (info) {
    var start_time = info.date
    new_task(start_time, start_time)
  },
  select: function (info) {
    var start_time = info.start
    var end_time = info.end
    new_task(start_time, end_time)
  }
});

calendar.render();

function update_task(info) {
  var event = info.event;
  $.ajax({
    type: 'PATCH',
    dataType: 'script',
    url: event._def.url,
    data: {
      authenticity_token: $('[name="csrf-token"]')[0].content,
      task: {
        id: event.id,
        event_id: gon.event_id,
        start_time: event.start,
        end_time: event.end ?  event.end : event.start
      },
      event_id: gon.event_id,
      id: event.id
    }
  });
}

function new_task(start_time, end_time) {
  $.ajax({
    type: 'GET',
    dataType: 'script',
    url: gon.url_new_task,
    data: {
      start_time: start_time,
      end_time: end_time
    }
  });
}
