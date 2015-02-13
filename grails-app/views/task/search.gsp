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
    <title>Search</title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> Search Result</h2>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <div class="control-group">
                            <g:each in="${tasks}" var="task">
                                <div class="controls">
                                <g:link controller="task" action="index" params="[id:task.id]"><h3>#${task.id} ${task.heading}</h3></g:link>
                                </div>
                            </g:each>

                            <g:if test="${tasks.size()==0}">
                                <h4>Sorry nothing matched the search Criteria</h4>
                            </g:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>





</body>
</html>