<link href='${resource(dir: "js", file: "fullcalendar/fullcalendar.css")}' rel='stylesheet' />
<link href='${resource(dir: "js", file: "fullcalendar/fullcalendar.print.css")}' rel='stylesheet' media='print' />
<script src='${resource(dir: "js", file: "fullcalendar/moment.min.js")}'></script>
<script src='${resource(dir: "js", file: "fullcalendar/fullcalendar.min.js")}'></script>
<script>

    $(document).ready(function() {

        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            defaultDate: '2015-02-12',
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events:"${createLink(controller: "task",action:"renderEvent")}"

        });

    });

</script>
<style>

body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
}

#calendar {
    max-width: 900px;
    margin: 0 auto;
}

</style>


<div id='calendar'></div>