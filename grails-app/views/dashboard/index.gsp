<%--
  Created by IntelliJ IDEA.
  User: sushant
  Date: 2/2/15
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">

    <title>Dashboard</title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> Overview</h2>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span6 pull-left">

                        <div class="widget">
                            <div class="widget-head">
                                <div class="pull-left">Task Assigned to me</div>
                                <div class="clearfix"></div>
                            </div>


                            <div class="widget-content">

                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Project</th>
                                            <th>Task Type</th>
                                            <th>Status</th>
                                            <th>Priority</th>
                                            <th>Subject</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${tdAssignedToMe}" var="task">
                                        <tr>
                                            <td><g:link controller="task" action="index" params="[id:task.id]">${task.id}</g:link></td>
                                            <td>${task.project.name}</td>
                                            <td>${task.taskType.name}</td>
                                            <td>${task.taskDetail?.last()?.status?.name}</td>
                                            <td>${task.taskDetail.last()?.priority?.priorityName}</td>
                                            <td><g:link controller="task" action="index" params="[id:task.id]">${task.heading}</g:link></td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="widget">
                            <div class="widget-head">
                                <div class="pull-left">Task Assigned by me</div>
                                <div class="clearfix"></div>
                            </div>


                            <div class="widget-content">

                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Project</th>
                                        <th>Task Type</th>
                                        <th>Status</th>
                                        <th>Priority</th>
                                        <th>Subject</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${tdAssignedByMe}" var="task">
                                        <tr>
                                            <td><g:link controller="task" action="index" params="[id:task.id]">${task.id}</g:link></td>
                                            <td>${task.project.name}</td>
                                            <td>${task.taskType.name}</td>
                                            <td>${task.taskDetail?.last()?.status?.name}</td>
                                            <td>${task.taskDetail.last()?.priority?.priorityName}</td>
                                            <td><g:link controller="task" action="index" params="[id:task.id]">${task.heading}</g:link></td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>
</body>
</html>