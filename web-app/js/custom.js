$('.dropdown-toggle').dropdown();

$(document).ready(function(){
    $(".futureDate").datepicker({minDate: new Date()});
    $(".futureDate").datepicker( "setDate" , new Date());

    $("#chooseProject").change(function(){
        if($(this).val()){
            $("#changeProjectForm").submit();
        }
    });

    /*$("#query").on("keyup",function(){
       console.log($(this).keyCode)
    })*/
});
