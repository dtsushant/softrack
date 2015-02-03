/**
 * Created with IntelliJ IDEA.
 * User: sushant
 * Date: 9/19/13
 * Time: 6:43 AM
 * To change this template use File | Settings | File Templates.
 */


function makeAjaxcall(url,data,divId)
{
    var bool = false;
    $.ajax({
        url:url,
        data:data,
        type:"POST",
        before:function(){

        },
        success:function(htmldata){
            $("#"+divId).html(htmldata)
            bool = true;
        }

    });
    return bool;

}