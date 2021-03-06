<%--
  Created by IntelliJ IDEA.
  User: spandey
  Date: 2/3/15
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <title>Documents</title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> Project Documents</h2>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <div class="control-group">

                            <div class="controls">
                            <g:render template="fileAttachmentForm"  model="[type:'project']"/>
                            </div>
                            </div>
                        <div class="control-group">
                            <g:each in="${attachments}" var="attachment">
                                <div class="controls">
                                    <g:link controller="task" action="uploadedFile" params="[id:attachment.id]">${attachment.name}</g:link>
                                </div>
                            </g:each>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>





</body>
</html>