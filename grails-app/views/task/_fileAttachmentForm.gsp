Add files... <input id="fileupload" type="file" multiple>
<div id="testtest">
    <table></table>
</div>
<g:hiddenField name="attachedIds" value="" />

<style>
.progress-bar{
    width: 400px;
}


</style>
<script src="${resource(dir: "js", file: "fileUpload/vendor/jquery.ui.widget.js")}" ></script>
<script src="${resource(dir: "js", file: "fileUpload/jquery.iframe-transport.js")}" ></script>
<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload.js")}" ></script>

<script>
    /*jslint unparam: true */
    /*global window, $ */

    $(function () {
        //'use strict';
        // Change this to the location of your server-side upload handler:
        var uploadId = 0;
        var url = "${createLink(controller: "task",action: "uploadFile")}?type=${type?:"task"}";
        $("#fileupload").fileupload({
            url: url,
            dataType: 'json',
            replaceFileInput:false,
            add:function(e, data){
                uploadId++;
                var container = $("#testtest").find("table");
                var appendTableRow = "<tr><td>" +
                        "<div class='progress' style='width: 0%; '></div>" +
                        "<div class='progress-percent'></div>" +
                        "</td>" +
                        "<td id='uploadButton"+uploadId+"'></td></tr>"
                container.append(appendTableRow);
                data.files[0].isCancelled = false;
                data.files[0].uploadID = 'uploadButton'+uploadId;
                var jqXHR=data.submit();
                data.context = $('<button/>').text('Cancel Upload')
                        .attr("class","cancel")
                        .appendTo($("#uploadButton"+uploadId))
                        .click(function(e){
                            data.files[0].isCancelled = true;
                            abortUpload(jqXHR,this,data);
                        });
            },
            done: function (e, data) {

                var currentUpload = data.files[0].uploadID;
                var progressObject = $("#"+currentUpload).parent().find("td:nth-child(2)");
                progressObject.html("Upload Complete");
                prevVal =$("#attachedIds").val()?$("#attachedIds").val()+",":"";
                console.log(data.result);
                $("#attachedIds").val(prevVal+data.result.attachedId);
                if(data.result.refreshPage==1){
                    window.location.reload();
                }
                //updateLink(data.result.totalCount);
            },
            progress:function(e,data){
                var currentUpload = data.files[0].uploadID;
                var progressObject = $("#"+currentUpload).parent().find("td:first");
                var progress = parseInt(data.loaded / data.total * 100, 10);
                progressObject.find('.progress').css(
                        'width',
                        progress + '%'
                );
                progressObject.find(".progress-percent").html(progress + '%');
            },
            fail:function(e,data){
                var currentUpload = data.files[0].uploadID;
                var progressObject = $("#"+currentUpload).parent().find("td:nth-child(2)");
                if(data.files[0].isCancelled)
                    progressObject.html("Upload Cancelled");
                else
                    progressObject.html("Upload Failed");

                console.log(e)
            }
        }).prop('disabled', !$.support.fileInput)
                .parent().addClass($.support.fileInput ? undefined : 'disabled');
    });

    function abortUpload(jqXHRObject,obj,data){
        var currentUpload = data.files[0].uploadID;
        var progressObject = $("#"+currentUpload).parent().find("td:first");
        jqXHRObject.abort();
        progressObject.find(".progress").css('width','0%');
        progressObject.find(".progress-percent").html('');
        $(obj).remove();
    }

</script>

%{--<div class="container">--}%
%{--<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->--}%
%{--<div class="row fileupload-buttonbar">--}%
%{--<div class="col-lg-7">--}%
%{--<!-- The fileinput-button span is used to style the file input field as button -->--}%
%{--<span class="btn btn-success fileinput-button">--}%
%{--<i class="glyphicon glyphicon-plus"></i>--}%
%{--<span>Add files...</span>--}%
%{--<input type="file" name="files[]" multiple>--}%
%{--</span>--}%
%{--<button type="button" class="btn btn-primary start">--}%
%{--<i class="glyphicon glyphicon-upload"></i>--}%
%{--<span>Start upload</span>--}%
%{--</button>--}%
%{--<button type="reset" class="btn btn-warning cancel">--}%
%{--<i class="glyphicon glyphicon-ban-circle"></i>--}%
%{--<span>Cancel upload</span>--}%
%{--</button>--}%
%{--<button type="button" class="btn btn-danger delete">--}%
%{--<i class="glyphicon glyphicon-trash"></i>--}%
%{--<span>Delete</span>--}%
%{--</button>--}%
%{--<input type="checkbox" class="toggle">--}%
%{--<!-- The global file processing state -->--}%
%{--<span class="fileupload-process"></span>--}%
%{--</div>--}%
%{--<!-- The global progress state -->--}%
%{--<div class="col-lg-5 fileupload-progress fade">--}%
%{--<!-- The global progress bar -->--}%
%{--<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">--}%
%{--<div class="progress-bar progress-bar-success" style="width:0%;"></div>--}%
%{--</div>--}%
%{--<!-- The extended global progress state -->--}%
%{--<div class="progress-extended">&nbsp;</div>--}%
%{--</div>--}%
%{--</div>--}%
%{--<!-- The table listing the files available for upload/download -->--}%
%{--<table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>--}%
%{--<br>--}%
%{--</div>--}%
%{--<!-- The blueimp Gallery widget -->--}%
%{--<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">--}%
%{--<div class="slides"></div>--}%
%{--<h3 class="title"></h3>--}%
%{--<a class="prev">‹</a>--}%
%{--<a class="next">›</a>--}%
%{--<a class="close">×</a>--}%
%{--<a class="play-pause"></a>--}%
%{--<ol class="indicator"></ol>--}%
%{--</div>--}%
%{--<!-- The template to display files available for upload -->--}%
%{--<script id="template-upload" type="text/x-tmpl">--}%
%{--{% for (var i=0, file; file=o.files[i]; i++) { %}--}%
%{--<tr class="template-upload fade">--}%
%{--<td>--}%
%{--<span class="preview"></span>--}%
%{--</td>--}%
%{--<td>--}%
%{--<p class="name">{%=file.name%}</p>--}%
%{--<strong class="error text-danger"></strong>--}%
%{--</td>--}%
%{--<td>--}%
%{--<p class="size">Processing...</p>--}%
%{--<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>--}%
%{--</td>--}%
%{--<td>--}%
%{--{% if (!i && !o.options.autoUpload) { %}--}%
%{--<button class="btn btn-primary start" disabled>--}%
%{--<i class="glyphicon glyphicon-upload"></i>--}%
%{--<span>Start</span>--}%
%{--</button>--}%
%{--{% } %}--}%
%{--{% if (!i) { %}--}%
%{--<button class="btn btn-warning cancel">--}%
%{--<i class="glyphicon glyphicon-ban-circle"></i>--}%
%{--<span>Cancel</span>--}%
%{--</button>--}%
%{--{% } %}--}%
%{--</td>--}%
%{--</tr>--}%
%{--{% } %}--}%
%{--</script>--}%
%{--<!-- The template to display files available for download -->--}%
%{--<script id="template-download" type="text/x-tmpl">--}%
%{--{% for (var i=0, file; file=o.files[i]; i++) { %}--}%
%{--<tr class="template-download fade">--}%
%{--<td>--}%
%{--<span class="preview">--}%
%{--{% if (file.thumbnailUrl) { %}--}%
%{--<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>--}%
%{--{% } %}--}%
%{--</span>--}%
%{--</td>--}%
%{--<td>--}%
%{--<p class="name">--}%
%{--{% if (file.url) { %}--}%
%{--<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>--}%
%{--{% } else { %}--}%
%{--<span>{%=file.name%}</span>--}%
%{--{% } %}--}%
%{--</p>--}%
%{--{% if (file.error) { %}--}%
%{--<div><span class="label label-danger">Error</span> {%=file.error%}</div>--}%
%{--{% } %}--}%
%{--</td>--}%
%{--<td>--}%
%{--<span class="size">{%=o.formatFileSize(file.size)%}</span>--}%
%{--</td>--}%
%{--<td>--}%
%{--{% if (file.deleteUrl) { %}--}%
%{--<button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>--}%
%{--<i class="glyphicon glyphicon-trash"></i>--}%
%{--<span>Delete</span>--}%
%{--</button>--}%
%{--<input type="checkbox" name="delete" value="1" class="toggle">--}%
%{--{% } else { %}--}%
%{--<button class="btn btn-warning cancel">--}%
%{--<i class="glyphicon glyphicon-ban-circle"></i>--}%
%{--<span>Cancel</span>--}%
%{--</button>--}%
%{--{% } %}--}%
%{--</td>--}%
%{--</tr>--}%
%{--{% } %}--}%
%{--</script>--}%

%{--<script src="js/"></script>--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/vendor/jquery.ui.widget.js")}" ></script>--}%
%{--<script src="http://blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>--}%
%{--<!-- The Load Image plugin is included for the preview images and image resizing functionality -->--}%
%{--<script src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.min.js"></script>--}%
%{--<!-- The Canvas to Blob plugin is included for image resizing functionality -->--}%
%{--<script src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>--}%
%{--<!-- Bootstrap JS is not required, but included for the responsive demo navigation -->--}%
%{--<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>--}%
%{--<!-- blueimp Gallery script -->--}%
%{--<script src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>--}%
%{--<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.iframe-transport.js")}" ></script>--}%
%{--<!-- The basic File Upload plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload.js")}" ></script>--}%
%{--<!-- The File Upload processing plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload-process.js")}" ></script>--}%
%{--<!-- The File Upload image preview & resize plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload-image.js")}" ></script>--}%
%{--<!-- The File Upload audio preview plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload-audio.js")}" ></script>--}%
%{--<!-- The File Upload video preview plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload-video.js")}" ></script>--}%
%{--<!-- The File Upload validation plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload-validate.js")}" ></script>--}%
%{--<!-- The File Upload user interface plugin -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/jquery.fileupload-ui.js")}" ></script>--}%
%{--<!-- The main application script -->--}%
%{--<script src="${resource(dir: "js", file: "fileUpload/main.js")}" ></script>--}%

